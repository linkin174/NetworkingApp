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
        guard let imageURL = imageURL else { return }
        if let cacheImage = ImageCache.shared.object(forKey: imageURL.path as NSString) {
            imageView.image = cacheImage
            activityIndicator.stopAnimating()
            return
        } else {
            downloadImage(from: imageURL)
        }
    }
    
    private func downloadImage(from url: URL) {
        activityIndicator.startAnimating()
        Task {
            do {
                if let image = UIImage(data: try await NetworkManager.shared.fetchImageAsync(from: url)) {
                    ImageCache.shared.setObject(image, forKey: url.path as NSString)
                    imageView.image = image
                    activityIndicator.stopAnimating()
                }
            } catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    func configureCell(with image: Image) {
        imageURL = URL(string: image.downloadUrl ?? "")
    }
}
