//
//  CustomCell.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    private var imageURL: URL? {
        didSet {
            imageView.image = nil
            updateImage()
        }
    }
    
    private func updateImage() {
        guard let imageURL = imageURL else { return }
        getImage(from: imageURL) { result in
            switch result {
            case .success(let image):
                if imageURL == self.imageURL {
                    self.imageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        // Get image from cache
        if let cacheImage = ImageCache.shared.object(forKey: url.path as NSString) {
            print("Image from cache: ", url.lastPathComponent)
            completion(.success(cacheImage))
            return
        }
        
        // Download image from url
        NetworkManager.shared.fetchImageAF(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                ImageCache.shared.setObject(image, forKey: url.path as NSString)
                print("Image from network: ", url.lastPathComponent)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func configureCell(with image: Image) {
        imageURL = URL(string: image.downloadUrl ?? "")
    }
}
