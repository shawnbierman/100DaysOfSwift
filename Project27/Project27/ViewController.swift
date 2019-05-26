//
//  ViewController.swift
//  Project27
//
//  Created by Shawn Bierman on 5/26/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: Any) {

        currentDrawType += 1
        if currentDrawType > 5 { currentDrawType = 0 }

        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerBoard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        default:
            break
        }
    }

    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)

            let context = ctx.cgContext
                context.setFillColor(UIColor.red.cgColor)
                context.setStrokeColor(UIColor.black.cgColor)
                context.setLineWidth(10)
                context.addRect(rectangle)
                context.drawPath(using: .fillStroke)
        }

        imageView.image = image
    }

    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)

            let context = ctx.cgContext
            context.setFillColor(UIColor.red.cgColor)
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(10)
            context.addEllipse(in: rectangle)
            context.drawPath(using: .fillStroke)
        }

        imageView.image = image
    }

    func drawCheckerBoard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            let context = ctx.cgContext
                context.setFillColor(UIColor.black.cgColor)

            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col) % 2 == 0 {
                        context.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }

        imageView.image = image
    }

    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            let context = ctx.cgContext
                context.translateBy(x: 256, y: 256)

            let rotations = 16
            let amount = Double.pi / Double(rotations)

            for _ in 0 ..< rotations {
                context.rotate(by: CGFloat(amount))
                context.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }

            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
        }

        imageView.image = image
    }

    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in
            let context = ctx.cgContext
                context.translateBy(x: 256, y: 256)

            var first = true
            var length: CGFloat = 256

            for _ in 0 ..< 256 {
                context.rotate(by: .pi / 2)

                if first {
                    context.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    context.addLine(to: CGPoint(x: length, y: 50))
                }

                length *= 0.99
            }

            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
        }

        imageView.image = image
    }

    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image { ctx in

            let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center

            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]

            let string = "The best-laid schemes o'\nmice an' men gang aft agley"

            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)

            let mouse = UIImage(named: "mouse")
                mouse?.draw(at: CGPoint(x: 300, y: 150))

        }

        imageView.image = image
    }
}
