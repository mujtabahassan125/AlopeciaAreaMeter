//
//  PhotoVC.swift
//  ImageRendering
//
//  Created by Mujtaba Hassan on 22/03/2024.
//

import UIKit
import PencilKit

class PhotoVC: UIViewController, PKCanvasViewDelegate {

    @IBOutlet weak var captureImage: UIImageView!
    var image: UIImage?
    let canvasView = PKCanvasView()
    var drawingView: DrawingView!
    
    var torchOn = false
    override func viewDidLoad() {
        super.viewDidLoad()

        captureImage.image = image
        
        // CanvasView setup
//        canvasView.frame = view.bounds
//        canvasView.backgroundColor = .clear
//        canvasView.isOpaque = false
//        canvasView.delegate = self
//        canvasView.drawingPolicy = .anyInput
//        canvasView.isUserInteractionEnabled = false
//        view.addSubview(canvasView)
        
        // Initialize the drawing view with the same frame as the imageView
        drawingView = DrawingView(frame: captureImage.bounds)
        drawingView.backgroundColor = .clear // Ensure the drawing view is transparent
        
        captureImage.addSubview(drawingView)
        captureImage.isUserInteractionEnabled = true
    }
    
    @IBAction func flashAction(_ sender: Any) {
        

        
    }
    func calculateHighlightedArea() -> CGFloat {
        let boundingBox = drawingView.drawPath.boundingBox
        // Assuming the image view's content mode is scaleAspectFit, calculate the scale factor
        let scaleFactorX = captureImage.image!.size.width / captureImage.bounds.width
        let scaleFactorY = captureImage.image!.size.height / captureImage.bounds.height
        let scaledWidth = boundingBox.width * scaleFactorX
        let scaledHeight = boundingBox.height * scaleFactorY
        
        return scaledWidth * scaledHeight // Returns area in image's pixel dimensions
    }
    
    func calculateHighlightedAreaInCM(DPI: CGFloat) -> CGFloat {
        let boundingBox = drawingView.drawPath.boundingBox
        // Assuming the image view's content mode is scaleAspectFit, calculate the scale factor
        let scaleFactorX = captureImage.image!.size.width / captureImage.bounds.width
        let scaleFactorY = captureImage.image!.size.height / captureImage.bounds.height
        let scaledWidth = boundingBox.width * scaleFactorX
        let scaledHeight = boundingBox.height * scaleFactorY
        
        // Convert pixels to cm using DPI
        let widthInCm = scaledWidth / DPI * 2.54
        let heightInCm = scaledHeight / DPI * 2.54
        
        // Calculate area in cm²
        let areaInCm² = widthInCm * heightInCm
        return areaInCm²
    }
    
    func openAreaDialog(area: String) {
        
        let storyboard = UIStoryboard(name: Storyboard.customAlerts.rawValue, bundle: nil)
        let customAlert = storyboard.instantiateViewController(withIdentifier: String(describing: CalculatedAreaAlertVC.self)) as! CalculatedAreaAlertVC
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalTransitionStyle = .crossDissolve
        customAlert.calculatedArea = area
        self.present(customAlert, animated: true, completion: nil)
    }
        
    
    
    


    @IBAction func drawAction(_ sender: Any) {
      //  canvasView.allowsFingerDrawing = true  // Enable finger drawing
//        canvasView.isUserInteractionEnabled = true
//        canvasView.drawingPolicy = .anyInput
        drawingView.highlightArea()
//        let area = drawingView.calculateArea()
//        print("Drawn Area: \(area) pixels²")
               // Convert area to your desired unit and display it
               // This example simply prints it to the console
            // let area = drawingView.calculateAreaInCm2(ppi: 460)
        
        let area = drawingView.calculateAreaInCm2(ppi: 400)
        openAreaDialog(area: area ?? "")
        print("Drawn Area: \(area) cm²")
        
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func deleteAction(_ sender: Any) {
        drawingView.resetDrawing()
    }
}

// Device model extension
public extension UIDevice {
    static var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
