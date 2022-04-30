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

    // MARK: - Public properties

    var image: Image!

    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        authorNameLabel.text = "Photo by \(image.author ?? "Unknown")"
    }

    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let image = imageView.image else { return }
        let shareVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = view
        present(shareVC, animated: true)
    }

    private func getImage() {
        guard let imageURL = URL(string: image.downloadUrl ?? "") else { return }
        if let cacheImage = ImageCache.shared.object(forKey: imageURL.path as NSString) {
            imageView.image = cacheImage
            activityIndicator.stopAnimating()
            return
        } else {
            Task {
                do {
                    let imageData = try await NetworkManager.shared.fetchImageAsync(from: imageURL)
                    self.imageView.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
