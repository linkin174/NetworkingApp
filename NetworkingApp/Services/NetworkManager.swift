//
//  NewtworkManager.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//
import Foundation
import UIKit

class NetworkManager {
    
    enum Result<Success, Error: Swift.Error> {
        case success(Success)
        case failure(Error)
    }
    
    static let shared = NetworkManager()
    
    let apiURLString = "https://picsum.photos/v2/list"
    
    func fetchData(from url: String, completion: @escaping ([Image]?, Error?) -> ()) {
        guard let url = URL(string: apiURLString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No errors")
                return
            }
            do {
                let images = try JSONDecoder().decode([Image].self, from: data)
                completion(images, nil)
            } catch let error {
                completion(nil, error)
                print(error)
            }
        }.resume()
    }
    init (){}
}
    
