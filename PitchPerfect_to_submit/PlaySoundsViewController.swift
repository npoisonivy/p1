//
//  PlaySoundsViewController.swift
//  PitchPerfect_to_submit
//
//  Created by Nikki L on 8/30/16.
//  Copyright © 2016 Nikki. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // create IBOutlet for all 4 buttons + 1 stop button
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // add this block of code after extension file is added
    var recordedAudioURL: NSURL!     // need to assign recordedAudioURL - 
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    // tag- 0 is slow (snail), 1 is Fast (Rabbit), 2 is Chipmunk, 3 is Vader ...
    // reality - 0 is chipmunk, 1 is Vader, 2 is Rabbit, 3 is snail.... -> so go to MSB and change the tag #
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader}
    
    @IBAction func playSoundForButton(sender: UIButton) {
        print("Play sound button pressed")
        // add code here - what to do when one of play button pressed
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        }
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("Stop audio button pressed")
        stopAudio()
    }
    
//    var recordedAudio: NSURL! // Passing from RSVC

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAudio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("View will appear")
        configureUI(.NotPlaying) // disable stop btn + enable play btn
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
