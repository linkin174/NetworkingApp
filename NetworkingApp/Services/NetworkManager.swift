//
//  NewtworkManager.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//
import Foundation

enum NetworkingErrors: Error {
    case badURL
    case noData
    case badDecoding
    case otherError
}

class NetworkManager {
    enum Links: String {
        case randomImage = "https://picsum.photos/1290/2780/"
        case randomImagesList = "https://picsum.photos/v2/list"
    }

    static let shared = NetworkManager()

    private init() {}
    
    func fetchImageAsync(from url: URL) async throws -> Data {
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw NetworkingErrors.badDecoding
        }
        return data
    }
    
    func fetchImage(from url: String) async -> Result<Data, NetworkingErrors> {
        var result: Result<Data, NetworkingErrors>
        guard let url = URL(string: url) else {
            result = .failure(.badURL)
            return result
        }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            result = .failure(.otherError)
            return result
        }
        result = .success(data)
        return result
    }
    
    func fetchImagesAsync(_ endPoint: String) async throws -> [Image] {
        guard let url = URL(string: NetworkManager.Links.randomImagesList.rawValue + endPoint) else {
            throw NetworkingErrors.badURL
        }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw NetworkingErrors.noData
        }
        guard let images = try? JSONDecoder().decode([Image].self, from: data) else {
            throw NetworkingErrors.badDecoding
        }
        return images
    }
}
