# TeleMedML

## Inspiration
 
With the recent COVID-19 pandemic, the healthcare industry as a whole has been subject to unprecedented strain. Hospitals and doctors all over the world have been overfilled and overworked because of this pandemic, and any innovation that could possibly save time, reduce exposure to the virus, and secure personal medical data in the process has the potential to save countless lives.
 
## What it does
 
TeleMedML provides a basic disease diagnosis for a user given a list of their symptoms. The user first selects which symptoms they are experiencing from a predefined menu. This information is then passed into a deep neural network, which analyzes the given data using a trained model, and returns the diagnosed disease as well as a confidence score. The user can also enter a short list of phrases describing their symptoms, which are sent to the server and analyzed using natural language processing, returning a diagnosis. Each data transaction is added to a series of pending transactions, which are subsequently verified using a proof-of-work algorithm and annexed to a block in the blockchain.
 
## How we built it
 
###### App
 
The iOS app begins with a secure login and signup page for users. Patients are able to view the entire history of previous transactions encrypted with SHA-256 hashes and secured on a decentralized blockchain network. A user is also able to fill out a symptoms form and write additional symptoms, which is encrypted and sent to the server for analysis. If the returned values indicate a potentially significant diagnosis, a doctor and patient are connected for real time communication, ensuring that a doctor’s valuable time is spent on those who need them the most.
 
###### Server
 
The flask-based server handles secured requests from clients and encodes all data points into blocks for storage in the blockchain network. Every time a client-side transaction occurs, the data is given a unique hash, encrypted, and linked to a previous block, chaining the data set together. A recursive algorithm was developed to work backwards through the blocks and decrypt the transaction data to securely access the full data set.
 
Alongside the server, a novel TensorFlow-based deep neural network machine learning model was also built and trained on a relevant data set. The data is reshaped on a 0 to 1 scale, regularized, and sent through 4 layers of decreasing node counts with relu and sigmoid activation functions to predict disease diagnoses based on inputted symptoms. This prediction was combined with Amazon Comprehend Natural Language Processing algorithms to analyze the connotation of written symptoms to quantify the severity of the diagnosis.
 
###### Website
 
A website was built as a healthcare portal to view all transactions made by clients. After a secure login, doctors are able to view a table containing full transaction data accessed and decrypted from the server using the recursive data access function.
 
## Challenges we ran into
 
One of the issues we encountered early on was establishing the infrastructure for the blockchain. Most of our group had relatively little experience with blockchain prior to the project, so figuring out how to implement each block, compute its hash, and connect it to the overall blockchain with a proof-of-work validation algorithm was challenging. Another difficulty we ran into was with sending requests to the server. We received internal server errors since the server we were hosting on was outdated and insufficiently large for the TensorFlow modules that our program incorporated, so we updated the server’s Python environment and upgraded its storage capacity.
 
## Accomplishments that we’re proud of
 
We are extremely proud of being able to successfully configure and train a deep neural network with an expansive dataset. This allows us to more accurately tailor the user’s diagnosis to his or her individual symptoms, creating a more personalized experience. We are also proud of managing to create a decentralized blockchain network using Python and encoding each transaction through a cryptographic hash function based on the current data and previous hash. The chaining functionality and the proof-of-work algorithm were also difficult to implement, so it was rewarding to be able to do so.
 
## What we learned
 
Given the current circumstances with the pandemic forcing us to work remotely, we had to learn how to communicate effectively and collaborate virtually in order to produce the desired end result. We also learned about the workings of blockchain technology, including the hashing and validation algorithm involved to ensure the security of the chain.

## What's next for TeleMedML
 
There are several future options that we can pursue with TeleMedML. Among these is the creation of a convolutional neural network that can analyze user images. The addition of this feature would be useful in diagnosing diseases with physical symptoms, broadening the abilities of our detection software. We could also integrate the project with certain hardware components, such as sensors that would measure the user’s heart rate, respiratory rate, and other vital signs to improve diagnosis accuracy.
