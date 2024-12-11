//
//  ImageDowloader.swift
//  TabBar3Apis
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    private init() {}
    private let imageCache = NSCache<NSString, UIImage>()
    
    func getImage(url: String?) async -> UIImage {
        guard let url = url else {
            return UIImage(named: "template") ?? UIImage()
        }
        
        // Check if the image is already in the cache
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            return cachedImage
        }
        
        // Fetch the image from the URL
        do {
            let dataUrl = URL(string: url)!
            let (data, _) = try await URLSession.shared.data(from: dataUrl)
            
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: url as NSString)
                return image
            } else {
                return UIImage(named: "template") ?? UIImage()
            }
        } catch {
            print("Error downloading image: \(error)")
            return UIImage(named: "template") ?? UIImage()
        }
    }
}
