//
//  ViewController.swift
//  Milestone9
//
//  Created by Shawn Bierman on 5/26/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import CoreGraphics
import UIKit

enum TextLocation {
    case top, bottom
}

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var addAHeaderButton: UIButton!
    @IBOutlet var addAFooterButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "MEME-O-TRONIC"
        view.backgroundColor = .white

        addAHeaderButton.isEnabled = false
        addAFooterButton.isEnabled = false

        setupNavigationBar()
    }

    fileprivate func setupNavigationBar() {

        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "DIN Condensed", size: 24)!,
            .foregroundColor: UIColor.black
        ]

        navigationController?.navigationBar.titleTextAttributes = textAttributes

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePhoto))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Import", style: .plain, target: self, action: #selector(importPhoto))
    }

    @IBAction func addHeaderText(_ sender: UIButton) {

        let ac = UIAlertController(title: "Header Text", message: nil, preferredStyle: .alert)
            ac.addTextField(configurationHandler: nil)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self, weak ac] _ in
                guard let message = ac?.textFields?[0].text else { return }
                if !message.isEmpty {
                    self?.generateTextOverlay(with: message, forPosition: .top)
                }
            }))

        present(ac, animated: true)
    }
    
    @IBAction func addFooterText(_ sender: UIButton) {

        let ac = UIAlertController(title: "Footer Text", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self, weak ac] _ in
            guard let message = ac?.textFields?[0].text else { return }
            if !message.isEmpty {
                self?.generateTextOverlay(with: message, forPosition: .bottom)
            }
        }))

        present(ac, animated: true)
    }

    fileprivate func generateTextOverlay(with string: String, forPosition position: TextLocation) {
        let width = imageView.bounds.width
        let height = imageView.bounds.height

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))

        let image = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center

            let shadow = NSShadow()
                shadow.shadowBlurRadius = 2
                shadow.shadowOffset = CGSize(width: 1, height: 1)
                shadow.shadowColor = UIColor.darkGray

            var fontSize: CGFloat = 40

            if position == .bottom { fontSize = 30 }

            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: fontSize),
                .paragraphStyle: paragraphStyle,
                .shadow: shadow,
                .foregroundColor: UIColor.white
            ]

            imageView.image?.draw(in: CGRect(x: 0, y: 0, width: width, height: height))

            let attributedString = NSAttributedString(string: string.uppercased(), attributes: attrs)

            if position == .top {
                addAHeaderButton.isEnabled = false
                attributedString.draw(with: CGRect(x: 0, y: 15, width: width, height: height),
                                      options: .usesLineFragmentOrigin, context: nil)
            } else {
                addAFooterButton.isEnabled = false
                attributedString.draw(with: CGRect(x: 0, y: 300, width: width, height: height),
                                      options: .usesLineFragmentOrigin, context: nil)
            }
        }
        imageView.image = image
    }
}

extension ViewController {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let imagePath = paths[0].appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        imageView.image = image

        if imageView.image != nil {
            addAHeaderButton.isEnabled = true
            addAFooterButton.isEnabled = true
        }

        dismiss(animated: true, completion: nil)
    }

    @objc func importPhoto() {

        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self

        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            picker.sourceType = .savedPhotosAlbum
        }

        present(picker, animated: true)
    }

    @objc func sharePhoto() {
        let items: [Any] = ["MEME-O-TRONIC Generated Photo", imageView.image!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)

        present(ac, animated: true)
    }
}
