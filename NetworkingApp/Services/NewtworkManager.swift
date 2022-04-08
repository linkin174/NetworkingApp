//
//  NewtworkManager.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//

import Foundation

class NewtworkManager {
    let images: [String] = []
    let shared = NewtworkManager()
    
    func fetchImages() {
        guard let imagesURL = URL(string: "https://picsum.photos/v2/list") else { return }
        URLSession.shared.dataTask(with: imagesURL) { data, _, error in
            
        }
    }
    
    init (){}
}
    
    
    
   

