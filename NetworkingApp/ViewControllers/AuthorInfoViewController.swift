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
        authorNameLabel.text = image.author ?? "No author"
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


