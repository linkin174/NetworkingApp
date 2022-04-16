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
    @IBOutlet var repeatButton: UIButton!
    @IBAction func repeatButtonPressed() {
        getImage()
    }
    
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let image = imageView.image else { return }
        let shareVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        present(shareVC, animated: true)
    }
    
    override func viewDidLoad() {
        repeatButton.layer.cornerRadius = repeatButton.frame.height / 2
        activityIndicator.color = .systemBackground
        getImage()
    }
    
    private func getImage() {
        repeatButton.isHidden = true
        activityIndicator.startAnimating()
        guard let imageURL = URL(string: NetworkManager.Links.randomImage.rawValue) else { return }
        NetworkManager.shared.fetchImageAF(from: imageURL ) { result in
            switch result {
            case .success(let image):
                    self.imageView.image = UIImage(data: image)
                    self.activityIndicator.stopAnimating()
                    self.repeatButton.isHidden = false
            case .failure(_):
                self.showAlert()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        repeatButton.isHidden.toggle()
    }
}


