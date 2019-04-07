//
//  ViewController.swift
//  mileston4
//
//  Created by Shawn Bierman on 4/6/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .camera, target: self, action: #selector(handleNewPhoto))
    }
    
    @objc fileprivate func handleNewPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate      = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let photoName = UUID().uuidString + ".jpg"
        let photoPath = getDocumentsDirectory().appendingPathComponent(photoName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.3) {
            try? jpegData.write(to: photoPath)
        }
        
        dismiss(animated: true, completion: nil)
        
        let ac = UIAlertController(title: "Caption", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak ac] _ in
            let caption = ac?.textFields?[0].text ?? photoName
            self?.photos.append(Photo(name: photoName, caption: caption))
            self?.tableView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            
            let photo           = photos[indexPath.row]
            vc.selectedImage    = photo.name
            vc.title            = photo.name
            vc.caption          = photo.caption
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let photo = photos[indexPath.row]
        let path  = getDocumentsDirectory().appendingPathComponent(photo.name)
        
        cell.imageView?.image       = UIImage(contentsOfFile: path.path)
        cell.textLabel?.text        = photo.name
        cell.detailTextLabel?.text  = photo.caption
        
        return cell
    }
}
