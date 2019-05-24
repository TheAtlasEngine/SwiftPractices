//
//  CameraViewController.swift
//  TestAVFoundation
//
//  Created by Kosuke Nishimura on 2019/05/19.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    
    static let shared = CameraViewController()
    
    let captureSession = AVCaptureSession()
    private var captureDevice: AVCaptureDevice!
    private var deviceInput: AVCaptureDeviceInput!
    private var livePreviewQueue: DispatchQueue!
    private var livePreviewLayer: AVCaptureVideoPreviewLayer!
    private var photoOutput: AVCapturePhotoOutput!
    private var photoSettings: AVCapturePhotoSettings!
    private var photo: CGImage!
    
    private let queueLabel = "CaptureQueue"
    static let storyboardIdentifier = "CameraViewController"
    
    var retakeButtonTapped: () -> Void = {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupCameraView()
    }
    
    private func setup() {
        cameraView.contentMode = .scaleToFill
    }
    
    @IBAction func captureButtonTapped(_ sender: Any) {
        capturePic()
    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func setupCameraView() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        guard let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            preconditionFailure("backCameraDevice failure")
        }
        
        self.captureDevice = backCameraDevice
        beginSession()
    }
    
    func beginSession() {
        
        do {
            self.deviceInput = try AVCaptureDeviceInput(device: self.captureDevice)
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
        
        guard self.deviceInput != nil else {
            preconditionFailure("deviceInput Failure")
        }
        
        if self.captureSession.canAddInput(self.deviceInput) {
            self.captureSession.addInput(self.deviceInput)
        }
        
        self.livePreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.livePreviewLayer.frame = self.cameraView.bounds
        self.livePreviewLayer.videoGravity = .resizeAspectFill
        self.cameraView.layer.masksToBounds = true
        self.cameraView.layer.addSublayer(self.livePreviewLayer)
        
        self.photoOutput = AVCapturePhotoOutput()
        
        if self.captureSession.canAddOutput(self.photoOutput) {
            self.captureSession.addOutput(self.photoOutput)
        }
        
        self.captureSession.startRunning()
    }
    
    private func getSettings() -> AVCapturePhotoSettings {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
        return settings
    }
    
    func stopCamera() {
        self.captureSession.stopRunning()
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func capturePic() {
        if photoOutput.connection(with: .video) != nil {
            self.photoOutput.capturePhoto(with: self.getSettings(), delegate: self)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            fatalError("ERROR: \(error!.localizedDescription)")
        }
        
        guard let photoData = photo.fileDataRepresentation() else {
            print("photodata is nil")
            return
        }
        
        guard let originalPhoto = UIImage(data: photoData) else {
            print("originalPhoto Failure")
            return
        }
        
        let orientation = originalPhoto.imageOrientation
        
        let activeFormat = self.deviceInput.device.activeFormat
        let description = activeFormat.formatDescription
        let dimensions = CMVideoFormatDescriptionGetDimensions(description)
        let photoWidth = CGFloat(integerLiteral: Int(dimensions.width))
        let photoHeight = CGFloat(integerLiteral: Int(dimensions.height))
        let cropOrigin = CGPoint(x: photoWidth / 2 - photoHeight / 2, y: 0)
        let cropSize = CGSize(width: photoHeight, height: photoHeight)
        let cropRect = CGRect(origin: cropOrigin, size: cropSize)
        
        guard let croppedCGImage = originalPhoto.cgImage?.cropping(to: cropRect) else {
            fatalError("cropImage Failure")
        }
        let croppedImage = UIImage(cgImage: croppedCGImage, scale: originalPhoto.scale, orientation: orientation)
        let id = CapturedPicPreviewViewController.storyboardIdentifier
        let capturedPicPreviewController = storyboard!.instantiateViewController(withIdentifier: id) as! CapturedPicPreviewViewController
        _ = capturedPicPreviewController.view
        capturedPicPreviewController.previewView.image = croppedImage
        
        //stopCamera()
        self.present(capturedPicPreviewController, animated: true, completion: nil)
    }
}
