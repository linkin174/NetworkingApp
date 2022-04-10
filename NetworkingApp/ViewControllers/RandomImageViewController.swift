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
    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let image = imageView.image else { return }
        let shareVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        present(shareVC, animated: true)
    }
    
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


