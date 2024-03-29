//
//  CameraVC.swift
//  ImageRendering
//
//  Created by Mujtaba Hassan on 19/03/2024.
//

import UIKit
import AVFoundation
import Vision
class CameraVC: UIViewController  {
    
    @IBOutlet weak var innerCameraView: UIView!
    @IBOutlet weak var preview: UIView!
    
    
    @IBOutlet weak var torchBtnIcon: UIButton!
    let captureSession = AVCaptureSession()
    lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    let videoDataOutput = AVCaptureVideoDataOutput()
    let photoOutput = AVCapturePhotoOutput()
    let requestHandler = VNSequenceRequestHandler()
    var paymentCardRectangleObservation: VNRectangleObservation?
    var torchOn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setCameraInput()
        showCameraFeed()
       // checkDeviceType()
        setCameraOutput(delegate: self)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startCamera(delegate: self)
    }
  /*
    func checkDeviceType() {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            isIphone = true
        case .pad:
            isIphone = false
        default:
            break
        }
    }
  */

    
    private func setupCamera() {
        
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(photoOutput) {
                    session.addOutput(photoOutput)
                }
                
                showCameraFeed()
            } catch {
                
            }
        }
    }
    
    func startCamera(delegate: AVCaptureVideoDataOutputSampleBufferDelegate) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.videoDataOutput.setSampleBufferDelegate(delegate, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    func stopCamera() {
        self.videoDataOutput.setSampleBufferDelegate(nil, queue: nil)
        self.captureSession.stopRunning()
    }
    
    func showCameraFeed() {
        
        previewLayer.videoGravity = .resizeAspectFill
        preview.layer.addSublayer(previewLayer)
        previewLayer.frame = self.preview.frame
    }
    
    // MARK: Session initialisation and video output
    func setCameraInput() {
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInDualCamera, .builtInWideAngleCamera, .builtInTrueDepthCamera],
            mediaType: .video,
            position: .back).devices.first else {
            return
        }
        try! device.lockForConfiguration()
        device.focusMode = .continuousAutoFocus
        device.unlockForConfiguration()
        if captureSession.canSetSessionPreset(AVCaptureSession.Preset.hd4K3840x2160) {
            captureSession.canSetSessionPreset(.hd4K3840x2160)
        } else if captureSession.canSetSessionPreset(AVCaptureSession.Preset.hd1920x1080) {
            captureSession.canSetSessionPreset(.hd1920x1080)
        } else if captureSession.canSetSessionPreset(AVCaptureSession.Preset.hd1280x720) {
            captureSession.canSetSessionPreset(.hd1280x720)
        } else {
            captureSession.sessionPreset = .high
        }
        //     captureSession.sessionPreset = .photo
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        self.captureSession.addInput(cameraInput)
    }
    func findVideoFormatHQPhotoSupported(device: AVCaptureDevice) -> AVCaptureDevice.Format? {
        for format in device.formats {
            if #available(iOS 15.0, *) {
                if format.isHighPhotoQualitySupported {
                    return format
                }
            } else {
                return nil
            }
        }
        return nil
    }
    func setCameraOutput(delegate: AVCaptureVideoDataOutputSampleBufferDelegate) {
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString): NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        // self.videoDataOutput.recommendedVideoSettings(forVideoCodecType: .h264, assetWriterOutputFileType: .mp4)
        
        self.videoDataOutput.setSampleBufferDelegate(delegate, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.photoOutput.maxPhotoQualityPrioritization = .quality
        self.captureSession.addOutput(self.videoDataOutput)
        self.captureSession.addOutput(self.photoOutput)
        
        guard let connection = self.videoDataOutput.connection(with: AVMediaType.video),
              connection.isVideoOrientationSupported else { return }
        connection.videoOrientation = .portrait
    }
    
    func navigateToCapturedImage(image: UIImage) {
        
        self.navigateToViewController(storyboardName: Storyboard.patient.rawValue, viewControllerIdentifier: String(describing: PhotoVC.self), viewModel: BaseViewModel()) { (vc: PhotoVC, nil) in
            vc.image = image
            return vc
        }

//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let photoVC = storyboard.instantiateViewController(withIdentifier: "PhotoVC")
//        guard let photoVC = photoVC as? PhotoVC else { return }
//        photoVC.modalPresentationStyle = .fullScreen
//        photoVC.image = image
//        navigationController?.pushViewController(photoVC, animated: false)
    }
    
    
    @IBAction func flashAction(_ sender: Any) {
        
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if torchOn {
                    device.torchMode = .off
                    torchOn = false
                    torchBtnIcon.imageView?.image = UIImage(systemName: "bolt.fill")
                   
                } else {
                    try device.setTorchModeOn(level: 1.0)
                    torchOn = true
                    torchBtnIcon.imageView?.image = UIImage(systemName: "bolt.slash.fill")
                }
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    @IBAction func patientListAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func settingsAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func captureBtnAction(_ sender: Any) {
        
        photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
}

extension CameraVC: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // MARK: AVCaptureVideo Delegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
          //  Utilities.securePrint("unable to get image from sample buffer")
            print("unable to get image from sample buffer")
            return
        }
        
    }
    
}

extension CameraVC: AVCapturePhotoCaptureDelegate {

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        guard let data = photo.fileDataRepresentation() else {
            return
        }
        
        stopCamera()
        let image = UIImage(data: data)
        let resizedImg =  image?.resizeImage(image: image ?? UIImage(), targetSize: CGSize(width: view.frame.width, height: view.frame.height))
        
        navigateToCapturedImage(image: resizedImg ?? UIImage())
//        // Converts the CMSampleBuffer to a CVPixelBuffer.
//        let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(sampleBuffer)
//        
//        print("Image Pixel Buffer")
//        DispatchQueue.main.sync { [self] in
//            // Converting Pixel buffer to CiImage and CiImage to uiImage
//            let ciImage: CIImage = CIImage(cvPixelBuffer: pixelBuffer ?? frame)
//            let frameImage = ciImage.convert(cmage: ciImage)
//            let resizedImg =  frameImage.resizeImage(image: frameImage, targetSize: CGSize(width: view.frame.width, height: view.frame.height))
//            navigateToCapturedImage(image: resizedImg ?? UIImage())
//        }

        
        print("Photo captured")
    }
}
