//
//  CustomCell.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var imageURL: URL? {
        didSet {
            imageView.image = UIImage(named: "dummy")
            updateImage()
        }
    }
    
    private func updateImage() {
        activityIndicator.startAnimating()
        guard let imageURL = imageURL else { return }
        if let cacheImage = ImageCache.shared.object(forKey: imageURL.path as NSString) {
            imageView.image = cacheImage
            return
        } else {
            downloadImage(from: imageURL)
        }
    }
    
    private func downloadImage(from url: URL) {
        Task {
            do {
                let image = UIImage(data: try await NetworkManager.shared.fetchImageAsync(from: url))
                imageView.image = image
                activityIndicator.stopAnimating()
            } catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    func configureCell(with image: Image) {
        imageURL = URL(string: image.downloadUrl ?? "")
    }
}
