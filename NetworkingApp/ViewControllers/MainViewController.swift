//
//  ViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - IBActions

    @IBAction func showRandomImagePressed() {
        performSegue(withIdentifier: "toRandomImage", sender: nil)
    }
    
    @IBAction func showGalleryButtonPressed() {
        performSegue(withIdentifier: "toImageGallery", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        view.sendSubviewToBack(imageView)
    }
    
    private func setBackgroundImage() {
        guard let url = getLinkDependingOnScreenSize() else { return }
        Task {
            do {
                guard let image = UIImage(data: try await NetworkManager.shared.fetchImageAsync(from: url)) else { return }
                //self.view.backgroundColor = UIColor(patternImage: image)
                imageView.image = image
                imageView.scaleAnimation()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getLinkDependingOnScreenSize() -> URL? {
        let width = Int(UIScreen.main.bounds.maxX) * 2
        let height = Int(UIScreen.main.bounds.maxY) * 2
        let url = URL(string: "https://picsum.photos/" + String(width) + "/" + String(height) + "/?blur=10")
        return url
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
