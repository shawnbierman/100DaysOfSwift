//
//  MainViewController.swift
//  Milestone10
//
//  Created by Shawn Bierman on 6/2/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionBackground: UIImageView!

    var cards = [URL]()

    var selectedCards = [Card]() {
        didSet {
            if self.selectedCards.count == 2 {
                compareCards(self.selectedCards)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionBackground.image = #imageLiteral(resourceName: "EarthBackground")

        findFlags()
    }

    override var prefersStatusBarHidden: Bool { return true }

    fileprivate func findFlags() {
        if let paths = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: "Flags.bundle") {
            cards += paths
            cards.shuffle()
            cards.removeSubrange(6...cards.count - 1)
            cards += cards
            cards.shuffle()
        }
    }

    fileprivate func compareCards(_ cards: [Card]) {

        guard let first = cards.first?.name else { return }
        guard let last = cards.last?.name else { return }

        if first == last {
            selectedCards.removeAll(keepingCapacity: true)

            cards.forEach { [weak self] card in
                if let cell = self?.collectionView.cellForItem(at: card.indexPath) as? CollectionViewCell {

                    UIView.animate(withDuration: 0.3, animations:  {
                        cell.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    }) { finished in

                        UIView.animate(withDuration: 0.5, animations: {
                            cell.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                        })
                    }
                }
            }
        } else {
            selectedCards.removeAll(keepingCapacity: true)

            cards.forEach { (card) in

                if let cell = collectionView.cellForItem(at: card.indexPath) as? CollectionViewCell {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {

                        UIView.transition(from: cell.frontImageView, to: cell.backImageView, duration: 0.4, options: .transitionFlipFromLeft, completion: nil)
                        cell.backImageView.isHidden = false
                        cell.frontImageView.isHidden = true
                    })
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }

        if cell.frontImageView.isHidden {

            let url = cards[indexPath.item]
            let image = UIImage(contentsOfFile: url.path)
            let filename = url.lastPathComponent

            UIView.transition(from: cell.backImageView,
                              to: cell.frontImageView,
                              duration: 0.2,
                              options: .transitionFlipFromRight,
                              completion: { [weak self] _ in

                                cell.backImageView.isHidden = true
                                cell.frontImageView.isHidden = false
                                cell.frontImageView.image = image

                                self?.selectedCards.append(Card(name: filename, indexPath: indexPath))
            })
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding: CGFloat = 440
        let size = (UIScreen.main.bounds.width - padding) / 3.5
        return CGSize(width: size, height: size)
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell
            else { fatalError("Unable to dequeue a CollectionViewCell") }

        cell.transform = .identity
        cell.isHidden = false

        cell.backImageView.isHidden = false
        cell.frontImageView.isHidden = true
        cell.backImageView.image = #imageLiteral(resourceName: "Earth")

        if cell.isHidden {
            print("cell is hidden")
            cell.isHidden = false
        } else {
            print("cell is visible")
        }

        print("isHidden: \(cell.isHidden)")
        print("alpha: \(cell.alpha)")
        print("transform: \(cell.transform)")
        print("backImageView.isHidden: \(cell.backImageView.isHidden)")
        print("frontImageView.isHidden: \(cell.frontImageView.isHidden)")
        print("backImageView.image: \(String(describing: cell.backImageView.image))")

        print("---")
        return cell
    }
}
