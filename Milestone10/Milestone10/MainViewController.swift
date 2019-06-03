//
//  MainViewController.swift
//  Milestone10
//
//  Created by Shawn Bierman on 6/2/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainViewController: UICollectionViewController {

    var items = [URL]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = UIColor(white: 0.92, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadGame))
        
        findFlags()
    }

    fileprivate func findFlags() {
        let paths = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: "Flags.bundle")

        if let paths = paths {
            items += paths
            items.removeSubrange(8...items.count - 1)
            items += items
            items.shuffle()
        }
    }

    @objc fileprivate func reloadGame() {
        print("reloading game...")
    }
}

// MARK: - Navigation
extension MainViewController {

    /*

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */

}

// MARK: - UICollectionViewDataSource
extension MainViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            fatalError("Unable to dequeue a CollectionViewCell")
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if cell.frontImageView.isHidden {

            // the backImageView is showing now
            // hide it
            // show frontImageView

            let image = UIImage(contentsOfFile: items[indexPath.item].path)
            cell.backImageView.isHidden = true
            cell.frontImageView.isHidden = false
            cell.frontImageView.image = image

            UIView.transition(from: cell.backImageView, to: cell.frontImageView,
                              duration: 0.2, options: .transitionFlipFromRight, completion: nil)
        } else {

            // the frontImageView is show now
            // hide it
            // show backImageView

            cell.backImageView.image = #imageLiteral(resourceName: "Earth")
            cell.frontImageView.isHidden = true
            cell.backImageView.isHidden = false

            UIView.transition(from: cell.frontImageView, to: cell.backImageView,
                              duration: 0.1,  options: .transitionFlipFromLeft, completion: nil)
        }
    }
}
