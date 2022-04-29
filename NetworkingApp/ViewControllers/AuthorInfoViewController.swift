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
        getImage()
        authorNameLabel.text = "Photo by \(image.author ?? "Unknown")"
    }
    
    private func getImage() {
        guard let imageURL = URL(string: image.downloadUrl ?? "") else { return }
        if let cacheImage = ImageCache.shared.object(forKey: imageURL.path as NSString) {
            imageView.image = cacheImage
            activityIndicator.stopAnimating()
            return 
        }
        Task {
            do {
                imageView.image = UIImage(data: try await NetworkManager.shared.fetchImageAsync(from: imageURL))
            } catch {
                print(error.localizedDescription)
            }
           
        }
//        NetworkManager.shared.fetchImageAF(from: imageURL) { result in
//            switch result {
//
//            case .success(let imageData):
//                self.imageView.image = UIImage(data: imageData)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}
