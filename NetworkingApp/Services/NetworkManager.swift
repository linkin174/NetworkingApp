//
//  NewtworkManager.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//
import Foundation
import UIKit
class NetworkManager {
    enum NetworkError: Error {
        case badURL
    }
    
    enum Links: String {
        case randomImage = "https://picsum.photos/1300/2800"
        case randomImagesList = "https://picsum.photos/v2/list"
    }
    
    enum Result<Success, Error: Swift.Error> {
        case success(Success)
        case failure(Error)
    }
    
    static let shared = NetworkManager()
    
    func fetchImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(error!))
                return
            }
            completion(.success(image))
        }.resume()
    }
    
    func fetchImages(from url: String, completion: @escaping (Result<[Image], Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                guard let images = try? JSONDecoder().decode([Image].self, from: data) else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(images))
            }
        }.resume()
    }

    init() {}
}
    
