//
//  CustomCell.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!

    func configureCell(with image: Image) {
        NetworkManager.shared.fetchImage(from: image.download_url ?? "") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: image)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
