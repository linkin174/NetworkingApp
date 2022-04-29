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
        guard let imageURL = URL(string: NetworkManager.Links.randomImage.rawValue) else { return }
        repeatButton.isHidden = true
        activityIndicator.startAnimating()
        Task {
            do {
                let imageData = try await NetworkManager.shared.fetchImageAsync(from: imageURL)
                imageView.image = UIImage(data: imageData)
                activityIndicator.stopAnimating()
                repeatButton.isHidden.toggle()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        repeatButton.isHidden.toggle()
    }
}


