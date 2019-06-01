//
//  SelectionViewController.swift
//  Project30
//
//  Created by TwoStraws on 20/08/2016.
//  Copyright (c) 2016 TwoStraws. All rights reserved.
//

import UIKit

// swiftlint:disable line_length
class SelectionViewController: UITableViewController {

    let fileManager = FileManager.default

	var filenames = [String]() // this is the array that will store the filenames to load
    var cachedFiles = [URL]()
	var dirty = false

    override func viewDidLoad() {
        super.viewDidLoad()

		title = "Reactionist"

		tableView.rowHeight = 90
		tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        buildImageCache()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dirty { tableView.reloadData() }
    }

    func findFiles() {
        guard let path = Bundle.main.resourcePath else { return }

        if let items = try? fileManager.contentsOfDirectory(atPath: path) {
            for item in items {
                if item.contains("Large") {
                    let filename = path.appending("/" + item)
                    filenames.append(filename)
                }
            }
        }
    }

    fileprivate func buildImageCache() {

        findFiles()

        guard !filenames.isEmpty else { return }

        if let cache = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            for file in filenames {
                for multiplier in (1...2).reversed() {

                    let size = multiplier * 90
                    let image = renderImage(for: file, at: CGSize(width: size, height: size))
                    if let jpegData = image.pngData() {

                        let filename = URL(fileURLWithPath: file).lastPathComponent.replacingOccurrences(of: "Large", with: "size-\(size)x\(size)")
                        let cachedFile = cache.appendingPathComponent(filename)
                        if multiplier == 2 { cachedFiles.append(cachedFile) } // save large only

                        do {
                            try jpegData.write(to: cachedFile)
                        } catch {
                            dump("Could not save: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }

    fileprivate func renderImage(for file: String, at size: CGSize) -> UIImage {

        let image = UIImage(contentsOfFile: file)
        let renderRect = CGRect(origin: .zero, size: CGSize(width: size.width, height: size.height))
        let renderer = UIGraphicsImageRenderer(size: renderRect.size)
        let roundedImage = renderer.image { ctx in
            ctx.cgContext.addEllipse(in: renderRect)
            ctx.cgContext.clip()
            image?.draw(in: renderRect)
        }

        return roundedImage
    }
}

// MARK: - Table view data source
extension SelectionViewController {

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return cachedFiles.count * 10 }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let filename = cachedFiles[indexPath.row % cachedFiles.count].path
        let image = UIImage(named: filename.replacingOccurrences(of: "size-180x180", with: "size-90x90"))
        cell.imageView?.image = image
        cell.imageView?.shadowPath()

        // each image stores how often it's been tapped
        let defaults = UserDefaults.standard
        cell.textLabel?.text = "\(defaults.integer(forKey: filename))"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageViewController = ImageViewController()
        let filename = cachedFiles[indexPath.row % cachedFiles.count].path
        imageViewController.image = filename
        imageViewController.owner = self

        // mark us as not needing a counter reload when we return
        dirty = false

        navigationController?.pushViewController(imageViewController, animated: true)
    }
}

// 1. Go through project 30 and remove all the force unwraps. Note: implicitly unwrapped
// optionals are not the same thing as force unwraps – you’re welcome to fix the implicitly
// unwrapped optionals too, but that’s a bonus task.

// 2. Pick any of the previous 29 projects that interests you, and try exploring it using
// the Allocations instrument. Can you find any objects that are persistent when they should
// have been destroyed?

// 3. For a tougher challenge, take the image generation code out of cellForRowAt: generate
// all images when the app first launches, and use those smaller versions instead. For bonus
// points, combine the getDocumentsDirectory() method I introduced in project 10 so that you
// save the resulting cache to make sure it never happens again.
