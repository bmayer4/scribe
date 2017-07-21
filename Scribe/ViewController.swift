//
//  ViewController.swift
//  Scribe
//
//  Created by Brett Mayer on 7/21/17.
//  Copyright © 2017 Devslopes. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {  //func of AVAudioPlayerDelegate
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }

    func requestSpeechAuth() {  //similar to maps
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        try self.audioPlayer = AVAudioPlayer(contentsOf: path)
                        self.audioPlayer.delegate = self //*important
                        self.audioPlayer.play()
                    } catch {
                        print(error)
                    }
                    
                    //above we played file, now were analyzing it
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was an error: \(error)")
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                    
                }
                }
            }

    }
    @IBAction func playButtonPressed(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }

}

