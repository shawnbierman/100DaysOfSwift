//
//  ViewController.swift
//  Project10
//
//  Created by Shawn Bierman on 3/17/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import LocalAuthentication
import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let cellId = "Person"
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(hideCollectionView), name: UIApplication.willResignActiveNotification, object: nil)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))

        authenticate()
    }

    @objc func hideCollectionView() {
        collectionView.isHidden = true
    }

    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) { picker.sourceType = .camera  }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath )
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] (success, authenticationError) in

                DispatchQueue.main.async {
                    if success {
                        self.collectionView.isHidden = false
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication. Please enter the super secret password.", preferredStyle: .alert)
            ac.addTextField { tf in
                tf.autocapitalizationType = .none
                tf.autocorrectionType = .no
                tf.isSecureTextEntry = true
            }
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak ac] _ in
                guard ac?.textFields?[0].text == "secret" else { return }
                self?.collectionView.isHidden = false
            }))
            self.present(ac, animated: true)
        }

}
}

extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell.")
        }

        let person = people[indexPath.item]
        cell.name.text = person.name

        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]

        let ac = UIAlertController(title: "Project 10", message: "Would you like to delete or rename this person?", preferredStyle: .actionSheet)

        // Delete button from ActionSheet
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            let dc = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
            dc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            dc.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                self?.people.remove(at: indexPath.item)
                self?.collectionView.reloadData()
            }))
            self?.present(dc, animated: true)
        }))

        // Rename button from ActionSheet
        ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { [weak self] _ in
            let rc = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
            rc.addTextField(configurationHandler: nil)
            rc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            rc.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak rc] _ in
                guard let newName = rc?.textFields?[0].text else { return }
                person.name = newName
                self?.collectionView.reloadData()
            }))
            self?.present(rc, animated: true)
        }))

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
}
