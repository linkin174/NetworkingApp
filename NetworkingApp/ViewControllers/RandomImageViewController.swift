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
        super.viewDidLoad()
        NetworkManager.shared.fetchImage(from: NetworkManager.Links.randomImage.rawValue) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }
    }

//    private func fetchImage() {
//        guard let url = URL(string: NetworkManager.Links.randomImage.rawValue) else { return }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, let response = response else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//            print(response)
//            guard let image = UIImage(data: data) else { return }
//            DispatchQueue.main.async {
//                self.imageView.image = image
////                self.activityIndicator.stopAnimating()
//            }
//        }.resume()
//}
}
