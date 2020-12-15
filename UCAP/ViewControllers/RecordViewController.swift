//
//  ViewController.swift
//  Catherine
//
//  Created by James Warmkessel on 11/20/20.
//

import UIKit

class RecordViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Poor(_ sender: Any) {
        RespondViewController.good = false
        performSegue(withIdentifier: "toRespond", sender: self)

    }
    @IBAction func Good(_ sender: Any) {
        RespondViewController.good = true
        //self.tabBarController?.selectedIndex = 1
        performSegue(withIdentifier: "toRespond", sender: self)
        //self.selectedIndex = 1

//        tabBarController.selectedIndex = 1
        // present a modal with an embed UINavigationController
//        self
//        let rvc = RespondViewController()
//        let vc = UINavigationController(rootViewController: rvc)
//        vc.modalPresentationStyle = .overFullScreen
//        present(vc, animated: true, completion: nil)
    }
   
 
    
}

