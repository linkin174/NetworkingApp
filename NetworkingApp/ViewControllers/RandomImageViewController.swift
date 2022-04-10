//
//  RandomImageViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 09.04.2022.
//

import UIKit

class RandomImageViewController: UIViewController {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        NetworkManager.shared.fetchImage(from: NetworkManager.Links.randomImage.rawValue) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: image)
                    self.activityIndicator.stopAnimating()
                }
            case .failure(_):
                self.showAlert()
            }
        }
    }
}


