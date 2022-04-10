//
//  ImageGalleryViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//

import UIKit

class ImageGalleryViewController: UICollectionViewController {
    // MARK: - IBOutlets

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    // MARK: - Public Properties

    var viewImages: [Image] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let authorVC = segue.destination as? AuthorInfoViewController else { return }
        authorVC.image = sender as? Image
/*            guard let cell = sender as? CustomCell, let indexPath = collectionView.indexPath(for: cell) else { return }
            guard let aboutVC = segue.destination as? AuthorInfoViewController else { return }
            aboutVC.image = viewImages[indexPath.item]
*/
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! CustomCell
        let image = viewImages[indexPath.item]
        cell.configureCell(with: image)
        return cell
    }
}

// MARK: - Extensions

extension ImageGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSideSize = UIScreen.main.bounds.width / 2 - 20
        return CGSize(width: cellSideSize, height: cellSideSize)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = viewImages[indexPath.item]
        performSegue(withIdentifier: "toAuthor", sender: image)
    }
}

