//
//  ViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - IBActions

    @IBAction func showRandomImagePressed() {
        performSegue(withIdentifier: "toRandomImage", sender: nil)
    }
    
    @IBAction func showGalleryButtonPressed() {
        performSegue(withIdentifier: "toImageGallery", sender: nil)
    }
    
    // MARK: - Private methods
    
    private func showAlert() {
        let alert = UIAlertController(title: "Oops", message: "Something went wrong... :(", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRandomImage" {
            guard let targetVC = segue.destination as? RandomImageViewController else { return }
            NetworkManager.shared.fetchImage(from: NetworkManager.Links.randomImage.rawValue) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        targetVC.imageView.image = UIImage(data: image)
                        targetVC.activityIndicator.stopAnimating()
                    }
                case .failure:
                    self.showAlert()
                }
            }
        } else {
            guard let galleryVC = segue.destination as? ImageGalleryViewController else { return }
            NetworkManager.shared.fetchImages(from: NetworkManager.Links.randomImagesList.rawValue) { result in
                switch result {
                case .success(let images):
                    DispatchQueue.main.async {
                        galleryVC.viewImages = images
                        galleryVC.activityIndicator.stopAnimating()
                    }
                case .failure:
                    self.showAlert()
                }
            }
        }
    }
}
