//
//  Image.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 08.04.2022.
//

import Foundation
import UIKit
 
struct Image: Codable {
//    let id: String?
    let author: String?
//    let width: Int?
//    let height: Int?
//    let url: String?
    let downloadUrl : String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case downloadUrl = "download_url"
    }
}


