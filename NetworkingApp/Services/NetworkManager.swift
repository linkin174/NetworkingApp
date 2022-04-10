//
//  NewtworkManager.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//
import Foundation

class NetworkManager {
    
    enum Links: String {
        case randomImage = "https://picsum.phots/1300/2800"
        case randomImagesList = "https://picsum.phots/v2/list"
    }

    static let shared = NetworkManager()
    
    func fetchImage(from url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if data != nil {
                completion(.success(data!))
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchImages(from url: String, completion: @escaping (Result<[Image], Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard
                let data = data,
                let images = try? JSONDecoder().decode([Image].self, from: data) else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(images))
        }.resume()
    }

    init() {}
}
    
