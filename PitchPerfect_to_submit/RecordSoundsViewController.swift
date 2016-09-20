//
//  RecordSoundsViewController.swift
//  PitchPerfect_to_submit
//
//  Created by Nikki L on 8/26/16.
//  Copyright © 2016 Nikki. All rights reserved.

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // create IBAction & IBOutlet for record button
    // create IBOutlet for record label
    // create IBAction & IBOutlet for stop button
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!  // use another way to connect this to storboard
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder:AVAudioRecorder!  // initialize class AVAudioRecorder, then we can call its func

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // disable stopRecordingButton
        // stopRecordingButton.enabled = false
        configureUI(isRecording: false)
    }


    // when it's recording or not, do below
    func configureUI(isRecording isRecording: Bool){
        recordingLabel.text = isRecording ? "Recording in progress": "Tap to Record"
        recordButton.enabled = !isRecording  // when recording, disable recordButton
        stopRecordingButton.enabled = isRecording // when recording, enable stopRecording button
    }

    
    // add IBAction for record button is pressed
    // link this action to button "Record Button" on Mainstoryboard
    @IBAction func recordAudio(sender: AnyObject) {
        print ("Record button is clicked")

        configureUI(isRecording: true)
        
        // When record button is pressed, need to set up filePath, for audioRecorder to start recording
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        // need Session to play and record - borrowing device's audio h/w - sharedInstance()
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    // add IBAction for stop recording Button
    @IBAction func stopRecording(sender: AnyObject) {
        print("stop Recording button is pressed")

        configureUI(isRecording: false)
        // enable recordButton
        // disable stopRecordingButton
        // change recordingLabel.text to "Tap to record"
        
        // use AVAudioRecorder func to stop Hardware from recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance() // borrowing h/w
        try! audioSession.setActive(false)
    }
    
    override func viewWillAppear(animated: Bool) {
        print ("View will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        print("View appeared")
    }
    
    // call this func with AVAudioRecorder done recording-> then call segue to next screen!
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished recording!")
        if (flag) {
            // if successfully recorded -> RSVC itself perform segue - audiourl path stays @ RSVC
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print("Saving of recording failed!")
        }
    }
    
    // in order to send this file path url to PSVC, we need PSVC
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // check if segue id == "stopRecording"
        if (segue.identifier == "stopRecording") {
            // pass audio url to PSVC
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}




