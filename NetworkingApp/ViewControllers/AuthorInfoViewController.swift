//
//  AuthorInfoViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 09.04.2022.
//

import UIKit

class AuthorInfoViewController: UIViewController {

    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    var image: Image!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.layer.cornerRadius = 8
        NetworkManager.shared.fetchImage(from: image.download_url ?? "") { result in
            
            switch result {
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
        authorNameLabel.text = "Photo by \(image.author ?? "No author")"
        view.layoutIfNeeded()
        }
    }



