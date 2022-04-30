//
//  RandomImageViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 09.04.2022.
//

// TODO: Разберись с алертом нафиг он нужен

import UIKit

class RandomImageViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var repeatButton: UIButton!
    
    override func viewDidLoad() {
        repeatButton.layer.cornerRadius = repeatButton.frame.height / 2
        activityIndicator.color = .systemBackground
        view.backgroundColor = .gray
        repeatButton.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        repeatButton.isHidden = false
        getImage()
    }
    
    @IBAction func repeatButtonPressed() {
        getImage()
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let image = imageView.image else { return }
        let shareVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = view
        present(shareVC, animated: true)
    }
    
    // MARK: - Method with direct data
    private func getImage() {
        guard let imageURL = URL(string: NetworkManager.Links.randomImage.rawValue) else {
            return }
        repeatButton.fadeOut()
        activityIndicator.startAnimating()
        Task {
            do {
                let imageData = try await NetworkManager.shared.fetchImageAsync(from: imageURL)
                imageView.image = UIImage(data: imageData)
                activityIndicator.stopAnimating()
                repeatButton.fadeIn()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }

    
    /*
    // MARK: - Method with Result
    private func getImage() {
        repeatButton.isHidden = true
        activityIndicator.startAnimating()
        Task {
            let result = try await NetworkManager.shared.fetchImage(from: NetworkManager.Links.randomImage.rawValue)
            switch result {
            case .success(let imageData):
                imageView.image = UIImage(data: imageData)
                activityIndicator.stopAnimating()
                repeatButton.isHidden.toggle()
            case .failure(let error):
                print(error)
            }
        }
    }
    */
}



