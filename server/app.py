import os
from flask import Flask, request
from flask_cors import CORS
from block import Block
from blockchain import Blockchain
import json
import requests
import time

import numpy as np # linear algebra
import pandas as pd

import machineLearn

# import firebase_admin
# from firebase_admin import credentials

# cred = credentials.Certificate("./telemedml-firebase-adminsdk-qjfev-447d6ff418.json")
# firebase_admin.initialize_app(cred)

blockchain = Blockchain()
blockchain.create_genesis_block()
# genesisBlock = Block("", ["First transaction"])

# print(genesisBlock.block_hash)

allRequests = []

app = Flask(__name__)
CORS(app)

machineLearn.initialize()

@app.route('/')
def main():
    return 'Welcome to TeleMedML.'

@app.route('/symptoms', methods=['POST'])
def symptoms():
    temp = request.headers['temperature']
    headache = request.headers['headache']
    cough = request.headers['cough']
    sneeze = request.headers['sneeze']
    congestion = request.headers['congestion']
    author = request.headers['author']

    diagnosis, confidence = machineLearn.predict(temp, headache, cough, sneeze, congestion)
    
    tx_data = request.get_json()
    tx_data['transactions']["diagnosis"] = diagnosis
    tx_data['transactions']["confidence"] = confidence
    # Append ML return to tx_data
    # required_fields = ["author", "content"]

    # for field in required_fields:
    #     if not tx_data.get(field):
    #         return "Invalid transaction data", 404

    tx_data["timestamp"] = time.time()
    print(tx_data)
    allRequests.append(tx_data)
    blockchain.add_new_transaction(tx_data)
    result = blockchain.mine()
    if not result:
        return "No transactions to mine"
    else:
        # Making sure we have the longest chain before announcing to the network
        chain_length = len(blockchain.chain)
        consensus()
        if chain_length == len(blockchain.chain):
            # announce the recently mined block to the network
            announce_new_block(blockchain.last_block)
            return str(result + "," + confidence)
        return "Block #{} is mined.".format(blockchain.last_block.index)
    
    return str(diagnosis + "," + confidence)

@app.route('/alldata', methods=['GET'])
def alldata():
    return "hi"

# @app.route('/hash', methods=['POST'])
# def hash():
#     newBlock = Block(genesisBlock.block_hash, [Flask.headers['message']])
#     return newBlock.block_hash

peers = set()

# endpoint to submit a new transaction. This will be used by
# our application to add new data (posts) to the blockchain
@app.route('/new_transaction', methods=['POST'])
def new_transaction():
    # Call ML function
    tx_data = request.get_json()
    # Append ML return to tx_data
    required_fields = ["author", "content"]

    for field in required_fields:
        if not tx_data.get(field):
            return "Invalid transaction data", 404

    tx_data["timestamp"] = time.time()
    print(tx_data)
    blockchain.add_new_transaction(tx_data)

    return "Success", 201


# endpoint to return the node's copy of the chain.
# Our application will be using this endpoint to query
# all the posts to display.
@app.route('/chain', methods=['GET'])
def get_chain():
    chain_data = []
    for block in blockchain.chain:
        chain_data.append(block.__dict__)
    return {"length": len(chain_data),
                       "chain": chain_data,
                       "peers": list(peers)}


# endpoint to request the node to mine the unconfirmed
# transactions (if any). We'll be using it to initiate
# a command to mine from our application itself.
@app.route('/mine', methods=['GET'])
def mine_unconfirmed_transactions():
    result = blockchain.mine()
    if not result:
        return "No transactions to mine"
    else:
        # Making sure we have the longest chain before announcing to the network
        chain_length = len(blockchain.chain)
        consensus()
        if chain_length == len(blockchain.chain):
            # announce the recently mined block to the network
            announce_new_block(blockchain.last_block)
        return "Block #{} is mined.".format(blockchain.last_block.index)


# endpoint to add new peers to the network.
@app.route('/register_node', methods=['POST'])
def register_new_peers():
    node_address = request.get_json()["node_address"]
    if not node_address:
        return "Invalid data", 400

    # Add the node to the peer list
    peers.add(node_address)

    # Return the consensus blockchain to the newly registered node
    # so that he can sync
    return get_chain()


@app.route('/register_with', methods=['POST'])
def register_with_existing_node():
    """
    Internally calls the `register_node` endpoint to
    register current node with the node specified in the
    request, and sync the blockchain as well as peer data.
    """
    node_address = request.get_json()["node_address"]
    if not node_address:
        return "Invalid data", 400

    data = {"node_address": request.host_url}
    headers = {'Content-Type': "application/json"}

    # Make a request to register with remote node and obtain information
    response = requests.post(node_address + "/register_node",
                             data=json.dumps(data), headers=headers)

    if response.status_code == 200:
        global blockchain
        global peers
        # update chain and the peers
        chain_dump = response.json()['chain']
        blockchain = create_chain_from_dump(chain_dump)
        peers.update(response.json()['peers'])
        return "Registration successful", 200
    else:
        # if something goes wrong, pass it on to the API response
        return response.content, response.status_code


def create_chain_from_dump(chain_dump):
    generated_blockchain = Blockchain()
    generated_blockchain.create_genesis_block()
    for idx, block_data in enumerate(chain_dump):
        if idx == 0:
            continue  # skip genesis block
        block = Block(block_data["index"],
                      block_data["transactions"],
                      block_data["timestamp"],
                      block_data["previous_hash"],
                      block_data["nonce"])
        proof = block_data['hash']
        added = generated_blockchain.add_block(block, proof)
        if not added:
            raise Exception("The chain dump is tampered!!")
    return generated_blockchain


# endpoint to add a block mined by someone else to
# the node's chain. The block is first verified by the node
# and then added to the chain.
@app.route('/add_block', methods=['POST'])
def verify_and_add_block():
    block_data = request.get_json()
    block = Block(block_data["index"],
                  block_data["transactions"],
                  block_data["timestamp"],
                  block_data["previous_hash"],
                  block_data["nonce"])

    proof = block_data['hash']
    added = blockchain.add_block(block, proof)

    if not added:
        return "The block was discarded by the node", 400

    return "Block added to the chain", 201


@app.route('/history', methods=['GET'])
def getHistory():
    return {'data': allRequests}

# endpoint to query unconfirmed transactions
@app.route('/pending_tx')
def get_pending_tx():
    return blockchain.unconfirmed_transactions


def consensus():
    """
    Our naive consnsus algorithm. If a longer valid chain is
    found, our chain is replaced with it.
    """
    global blockchain

    longest_chain = None
    current_len = len(blockchain.chain)

    for node in peers:
        response = requests.get('{}chain'.format(node))
        length = response.json()['length']
        chain = response.json()['chain']
        if length > current_len and blockchain.check_chain_validity(chain):
            current_len = length
            longest_chain = chain

    if longest_chain:
        blockchain = longest_chain
        return True

    return False


def announce_new_block(block):
    """
    A function to announce to the network once a block has been mined.
    Other blocks can simply verify the proof of work and add it to their
    respective chains.
    """
    for peer in peers:
        url = "{}add_block".format(peer)
        headers = {'Content-Type': "application/json"}
        requests.post(url,
                      data=json.dumps(block.__dict__, sort_keys=True),
                      headers=headers)

if __name__ == '__main__':
    # Bind to PORT if defined, otherwise default to 5000.
    port = int(os.environ.get('PORT', 80))
    app.run(host='0.0.0.0', port=port)