//
//  NewtworkManager.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//
import Alamofire
import Foundation

class NetworkManager {
    enum Links: String {
        case randomImage = "https://picsum.photos/1300/2800/"
        case randomImagesList = "https://picsum.photos/v2/list?page=1&limit=10"
        case randomImageSetupList = "https://picsum.photos/v2/list?page="
    }

    static let shared = NetworkManager()

    private init() {}

    func fetchImageAF(from url: URL, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

    func fetchImagesAF(from url: URL, completion: @escaping (Result<[Image], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let images = try JSONDecoder().decode([Image].self, from: data)
                        completion(.success(images))
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    completion(.failure(.createURLRequestFailed(error: error)))
                }
            }
    }
}
