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
}

extension UIViewController {
    func showAlert() {
        let alert = UIAlertController(title: "Oops", message: "Something went wrong... :(", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
