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
    override func viewDidLoad() {
        super.viewDidLoad()

        captureImage.image = image
        
        // CanvasView setup
        canvasView.frame = view.bounds
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        canvasView.delegate = self
        canvasView.drawingPolicy = .anyInput
        canvasView.isUserInteractionEnabled = false
        view.addSubview(canvasView)
    }
    


    @IBAction func drawAction(_ sender: Any) {
      //  canvasView.allowsFingerDrawing = true  // Enable finger drawing
        canvasView.isUserInteractionEnabled = true
        canvasView.drawingPolicy = .anyInput
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func deleteAction(_ sender: Any) {
    }
}
