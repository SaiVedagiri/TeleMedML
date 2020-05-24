//
//  DoctorCallVC.swift
//  TeleMedML
//
//  Created by Arya Tschand on 5/23/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class DoctorCallVC: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo()
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name:
        NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "headphone", ofType:"mov") else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
            
        }
    }
    
    @objc func videoDidEnd(notification: NSNotification) {
       _ = navigationController?.popViewController(animated: true)

    }
}
