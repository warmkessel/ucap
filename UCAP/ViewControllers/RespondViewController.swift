//
//  ViewController.swift
//  Catherine
//
//  Created by James Warmkessel on 11/20/20.
//

import UIKit

class RespondViewController: UIViewController {
    static var good = true
//        print()

    var goodReponse : [String] = []
    var badReponse : [String] = []
    var timer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        goodReponse = []
        let gcount = Int(NSLocalizedString("goodReponse", comment: "Number of array items")) ?? 0
        for index in 0...(gcount - 1) {
            goodReponse.append(NSLocalizedString("goodReponse\(index)", comment: "Array of good Reponse"))
        }
        badReponse = []
        let bcount = Int(NSLocalizedString("badReponse", comment: "Number of array items")) ?? 0
        for index in 0...(bcount - 1) {
            badReponse.append(NSLocalizedString("badReponse\(index)", comment: "Array of bad Reponse"))
        }
        // Do any additional setup after loading the view.

    }
    //new function
    @objc func timerAction(){
        dismiss()
          timer?.invalidate()
    }
    
    @IBAction func Dismiss(_ sender: Any) {
        dismiss()
    }
    
    func dismiss(){
        self.dismiss(animated: true, completion: nil)

    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        if(RespondViewController.good){
            setGood()
        }
        else{
            setBad()
        }
        //in a function or viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)


        
    }
    @IBOutlet weak var respond: UILabel!
    
    func setGood(){
        respond.text = goodReponse[getGoodLoc()]
    }
    func setBad(){
        respond.text = badReponse[getBadLoc()]
    }
    func getGoodLoc() -> Int{
        return Int.random(in: 0..<goodReponse.count)
    }
    func getBadLoc() -> Int{
        return Int.random(in: 0..<badReponse.count)

    }
}

