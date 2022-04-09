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
        NetworkManager.shared.fetchImage(from: NetworkManager.Links.randomImage.rawValue) { result in
            print(result)
            switch result {
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
//
//extension UIViewController {
//    func showAlert(with error: Error?) {
//        let alert = UIAlertController(title: error, message: error as? CustomStringConvertible as! String, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//        present(alert, animated: true)
//    }
//}
