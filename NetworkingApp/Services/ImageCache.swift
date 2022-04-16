//
//  ImageCache.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 15.04.2022.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
