import UIKit

class DrawingView: UIView {
    var drawPath = CGMutablePath()
    var points: [CGPoint] = [] // Stores the points for area calculation
    private var strokeColor: UIColor = ColorConstants.primary
    private var lineWidth: CGFloat = 5
    var fillColor: UIColor = UIColor.blue.withAlphaComponent(0.5) // Semi-transparent fill color
    private var shouldFill: Bool = false // Determines whether to fill the path

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        drawPath.move(to: point)
        points.append(point) // Start a new set of points
        shouldFill = false // Reset fill state on new touch
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        drawPath.addLine(to: point)
        points.append(point) // Add point to the array
        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        if shouldFill {
            // Fill the path with the semi-transparent color
            context.addPath(drawPath)
            context.setFillColor(fillColor.cgColor)
            context.fillPath()
        }

        // Always draw the path stroke
        context.addPath(drawPath)
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(lineWidth)
        context.strokePath()
    }

    // Resets the current drawing
    func resetDrawing() {
        drawPath = CGMutablePath()
        points.removeAll()
        shouldFill = false
        setNeedsDisplay()
    }

    // Highlight the drawn area by filling it
    func highlightArea() {
        shouldFill = true
        setNeedsDisplay()
    }

    // Calculate the area of the drawn shape using the shoelace formula
    func calculateArea() -> CGFloat {
        guard points.count >= 3 else { return 0 }

        let area = points.enumerated().reduce(0) { sum, elem in
            let j = (elem.offset + 1) % points.count
            return sum + points[elem.offset].x * points[j].y - points[j].x * points[elem.offset].y
        } / 2.0
        return abs(area)
    }
    
    func calculateAreaInCm2(ppi: CGFloat) -> String? {
        guard points.count >= 3 else { return nil }
        
        // Calculate area in pixels² using the shoelace formula
        let pixelArea = points.enumerated().reduce(0) { sum, elem in
            let j = (elem.offset + 1) % points.count
            return sum + points[elem.offset].x * points[j].y - points[j].x * points[elem.offset].y
        } / 2.0
        
        let areaInPixels = abs(pixelArea)
        
        // Convert area from pixels² to inches²
        let areaInInches = areaInPixels / (ppi * ppi)
        
        // Convert area from inches² to cm² (1 inch² = 6.4516 cm²)
        let areaInCm = (areaInInches * 6.4516) * 10
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        if let formattedNumber = formatter.string(from: NSNumber(value: areaInCm)) {
            print(formattedNumber) // Output: 10.46
            return formattedNumber
        }
        
        return nil
        
       
    }
    
    func calculateRealImageArea(ppi: CGFloat, imageView: UIImageView, drawingView: DrawingView) -> CGFloat {
        guard let imageSize = imageView.image?.size else { return 0 }
        let viewSize = imageView.bounds.size

        // Determine the scale factor based on the content mode of imageView
        var scaleFactor: CGFloat = 1.0
        if imageView.contentMode == .scaleAspectFit {
            let widthRatio = viewSize.width / imageSize.width
            let heightRatio = viewSize.height / imageSize.height
            scaleFactor = min(widthRatio, heightRatio)
        } else if imageView.contentMode == .scaleAspectFill {
            let widthRatio = viewSize.width / imageSize.width
            let heightRatio = viewSize.height / imageSize.height
            scaleFactor = max(widthRatio, heightRatio)
        }
        // scaleFactor now reflects how the image is scaled in the imageView

        // Adjust drawing points to the scale of the original image
        let adjustedPoints = drawingView.points.map { CGPoint(x: $0.x / scaleFactor, y: $0.y / scaleFactor) }

        // Use the adjusted points to calculate the area (using the shoelace formula, as before)
        let realImageAreaPixels = calculatePolygonArea(points: adjustedPoints)

        // Convert area from pixels² to cm² using PPI
        let areaInCm2 = (realImageAreaPixels / (ppi * ppi)) * 6.4516 // Convert pixels² to cm²

        return areaInCm2
    }

    func calculatePolygonArea(points: [CGPoint]) -> CGFloat {
        guard points.count >= 3 else { return 0 }
        let area = points.enumerated().reduce(0) { sum, elem in
            let j = (elem.offset + 1) % points.count
            return sum + points[elem.offset].x * points[j].y - points[j].x * points[elem.offset].y
        } / 2.0
        return abs(area)
    }

}
