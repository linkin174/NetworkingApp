//
//  ViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//

import UIKit

class ViewController: UIViewController {
  
    @IBAction func showGalleryButtonPressed() {
        performSegue(withIdentifier: "toImageGalery", sender: nil)
    }
}

