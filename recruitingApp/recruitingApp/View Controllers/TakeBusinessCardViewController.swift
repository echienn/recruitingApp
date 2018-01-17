//
//  TakeBusinessCardViewController.swift
//  recruitingApp
//
//  Created by Elaine Chien on 12/21/17.
//  Copyright © 2017 Shubham Gupta. All rights reserved.

//sources: https://stackoverflow.com/questions/39894630/how-to-get-front-camera-back-camera-and-audio-with-avcapturedevicediscoverysess
//

import UIKit
import AVFoundation

class TakeBusinessCardViewController: UIViewController, AVCapturePhotoCaptureDelegate{

    //middleman between AVCaptureInput and AVCaptureOutputs
    var captureSession: AVCaptureSession?
    //view that will let us preview what is being captured
    @IBOutlet weak var imageViewOverlay: UIImageView!
  
    var previewLayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput? = nil
    var captureDevice: AVCaptureDeviceInput?
    var selectedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession = AVCaptureSession()
        createAndLayoutPreviewLayer(fromSession: captureSession)
        configureCaptureSession(forDevicePosition: .unspecified)
        captureSession?.startRunning()
        toggleUI(isInPreviewMode: false)
    }
   
    func configureCaptureSession(forDevicePosition devicePostion: AVCaptureDevice.Position) {
        guard let captureSession = captureSession else {
            print("captureSession has not been initialized")
            return
        }
        
        // specifies that we want high quality video captured from the device
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        let all_devices = AVCaptureDevice.DiscoverySession.init(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],mediaType: AVMediaType.video,position: AVCaptureDevice.Position.unspecified)
        
        var camera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: devicePostion).devices[1]
        for device in all_devices.devices{
            if device.position == AVCaptureDevice.Position.back {
                camera = device
            }
        }
        
        
        do {
            // TODO: add an input and output to our AVCaptureSession
            let input = try AVCaptureDeviceInput(device: camera)
            captureSession.addInput(input)
            //photoOutput = AVCapturePhotoOutput()
            //captureSession.addOutput(photoOutput!)
           /* photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecJPEG])], completionHandler: nil)
 
            if captureSession.canAddOutput(photoOutput) { captureSession.addOutput(photoOutput) }
 
            captureSession.startRunning()
 */
            
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func createAndLayoutPreviewLayer(fromSession session: AVCaptureSession?) {
        // TODO: initialize previewLayer
         previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
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
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        
        let pic: UIImage = UIImage(data: photo.fileDataRepresentation()!)!
        selectedImage = pic
        toggleUI(isInPreviewMode: true)
    }
    
    func toggleUI(isInPreviewMode: Bool) {
        if isInPreviewMode {
            imageViewOverlay.image = selectedImage
            //takePhotoButton.isHidden = true
            //sendButton.isHidden = false
            //cancelButton.isHidden = false
            //flipCameraButton.isHidden = true
            
        }
        else {
            //takePhotoButton.isHidden = false
            //sendButton.isHidden = true
            //cancelButton.isHidden = true
            imageViewOverlay.image = nil
            //flipCameraButton.isHidden = false
        }
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

