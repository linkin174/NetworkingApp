//
//  AuthorInfoViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 09.04.2022.
//

import UIKit

class AuthorInfoViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let image = imageView.image else { return }
        let shareVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        present(shareVC, animated: true)
    }
    // MARK: - Public properties

    var image: Image!

    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchImage(from: image.download_url ?? "") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: image)
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
        authorNameLabel.text = "Photo by \(image.author ?? "Unknown")"
    }
}
