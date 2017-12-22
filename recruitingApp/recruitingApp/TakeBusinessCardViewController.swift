//
//  TakeBusinessCardViewController.swift
//  recruitingApp
//
//  Created by Elaine Chien on 12/21/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.
//

import UIKit
import AVFoundation

class TakeBusinessCardViewController: UIViewController {

    //middleman between AVCaptureInput and AVCaptureOutputs
    var captureSession: AVCaptureSession?
    //view that will let us preview what is being captured
    @IBOutlet weak var imageViewOverlay: UIImageView!
  
    var previewLayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession = AVCaptureSession()
        createAndLayoutPreviewLayer(fromSession: captureSession)
        configureCaptureSession(forDevicePosition: .unspecified)
        imageViewOverlay.image = nil

        // Do any additional setup after loading the view.
    }
    
    func configureCaptureSession(forDevicePosition devicePostion: AVCaptureDevice.Position) {
        guard let captureSession = captureSession else {
            print("captureSession has not been initialized")
            return
        }
        
        // specifies that we want high quality video captured from the device
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        
        // This line will need to be edited for part 5.
        // It has a bad name (and is poorly written syntactically) because we want
        // you to think about what it's type should be.
        let camera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: devicePostion).devices[1]
        
        do {
            // TODO: add an input and output to our AVCaptureSession
            let input = try AVCaptureDeviceInput(device: camera)
            captureSession.addInput(input)
            self.photoOutput = AVCapturePhotoOutput()
            self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecJPEG])], completionHandler: nil)
            
            if captureSession.canAddOutput(self.photoOutput!) { captureSession.addOutput(self.photoOutput!) }
            
            captureSession.startRunning()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func createAndLayoutPreviewLayer(fromSession session: AVCaptureSession?) {
        // TODO: initialize previewLayer
        previewLayer = AVCaptureVideoPreviewLayer()
        guard let previewLayer = previewLayer else {
            print("previewLayer hasn't been initialized yet!")
            return
        }
        
        // these two lines add the previewlayer to our viewcontroller's view programattically
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.layer.frame
        previewLayer.zPosition = -1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
