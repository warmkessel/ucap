//
//  ViewController.swift
//  Catherine
//
//  Created by James Warmkessel on 11/20/20.
//

import UIKit
import ARKit
import AVFoundation

class ARViewController: UIViewController {
//    override func viewDidLoad() {
//             super.viewDidLoad()
//             let config = ARWorldTrackingConfiguration()
//             config.planeDetection = .horizontal
//             sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
//             //sceneView.delegate = self
//             sceneView.session.run(config)
//      }
    var forwardCamera = true
    @IBAction func photo(_ sender: Any) {
        takeScreenshot(true)
    }
    
    @IBAction func rotate(_ sender: Any) {
        forwardCamera = !forwardCamera
        if(forwardCamera){
            let configuration = ARWorldTrackingConfiguration()
            configuration.isLightEstimationEnabled = true
            sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        }
        else{
            guard ARFaceTrackingConfiguration.isSupported else { return }
            let configuration = ARFaceTrackingConfiguration()
            configuration.isLightEstimationEnabled = true
            sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        }
        //recenter()

    }
    open func takeScreenshot(_ shouldSave: Bool = true) {
        playSound()
        UIImageWriteToSavedPhotosAlbum(self.sceneView.snapshot(), nil, nil, nil)
       }
    @IBOutlet weak var sceneView: ARSCNView!
    var boxNode = SCNNode()

    override func viewDidLoad() {
           super.viewDidLoad()
        let config = ARWorldTrackingConfiguration()
        sceneView.session.run(config)
        sceneView.scene = addBox()
    }
    
    @IBAction func recenter(_ sender: Any) {
        recenter()
    }
    func recenter(){
        let position = SCNVector3(x: 0, y: 0, z: -0.2)
        if(sceneView.pointOfView != nil){
            let cameraNode = sceneView.pointOfView!
            updatePositionAndOrientationOf(boxNode, withPosition: position, relativeTo: cameraNode)
        }
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        recenter()
    }
    func addBox() -> SCNScene{
        //let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let box = SCNPlane(width: 0.1, height: 0.1)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        material.diffuse.contents = #imageLiteral(resourceName: "davejackjeb2.png")
        box.materials = [material]
        boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(0, 0, -0.2)
        let scene = SCNScene()
        scene.rootNode.addChildNode(boxNode)
        return scene
    }
    func updatePositionAndOrientationOf(_ node: SCNNode, withPosition position: SCNVector3, relativeTo referenceNode: SCNNode) {
        let referenceNodeTransform = matrix_float4x4(referenceNode.transform)

        // Setup a translation matrix with the desired position
        var translationMatrix = matrix_identity_float4x4
        translationMatrix.columns.3.x = position.x
        translationMatrix.columns.3.y = position.y
        translationMatrix.columns.3.z = position.z

        // Combine the configured translation matrix with the referenceNode's transform to get the desired position AND orientation
        let updatedTransform = matrix_multiply(referenceNodeTransform, translationMatrix)
        node.transform = SCNMatrix4(updatedTransform)
    }

    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "camera", withExtension: "wav") else { return }

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
}
