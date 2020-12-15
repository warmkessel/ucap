//
//  ViewController.swift
//  Catherine
//
//  Created by James Warmkessel on 11/20/20.
//

import UIKit
import AVFoundation

class SlideViewController: UIViewController {
    let imageList = [UIImage(named: "slideshow/Photo1"), UIImage(named: "slideshow/Photo2"), UIImage(named: "slideshow/Photo3"), UIImage(named: "slideshow/Photo4"), UIImage(named: "slideshow/Photo5"), UIImage(named: "slideshow/Photo6"), UIImage(named: "slideshow/Photo7"), UIImage(named: "slideshow/Photo8"), UIImage(named: "slideshow/Photo9"), UIImage(named: "slideshow/Photo10")]
    

    var currentShow : [UIImage?]? = nil
    var timer : Timer?
    var player: AVAudioPlayer?
    var mute: Bool = false
    
    @IBOutlet weak var speaker: UIImageView!
    @IBOutlet weak var slideShow: UIImageView!

    @IBAction func NextSlide(_ sender: Any) {
        timer?.invalidate()
        runShow()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @IBAction func muteTapped(_ sender: Any) {
        mute = !mute
        if(mute){
            player?.pause()
        }
        else{
            player?.play()

        }
        speaker.image = UIImage(systemName: mute ? "speaker.slash" : "speaker")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        runShow()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        if(!mute){
            playSound()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer?.invalidate()
        currentShow = self.imageList
        player?.stop()

    }
    func runShow(){
      
        if(currentShow == nil || currentShow?.count == 0){
            currentShow = self.imageList
        }
        let loc = Int.random(in: 0..<currentShow!.count)
        slideShow.image =   currentShow?[loc]
        currentShow?.remove(at: loc)
    }



    func playSound() {
        guard let url = Bundle.main.url(forResource: "Icarus", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    @objc func timerAction(){
        runShow()
    }
    
 
    
}

