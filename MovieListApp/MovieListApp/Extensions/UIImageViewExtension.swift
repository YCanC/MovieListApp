//
//  UIImageView.swift
//  MovieListApp
//
//  Created by yasar.cilingir on 18.02.2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setRemoteImage(url: URL, movieId: NSNumber) {
        if let cachedImage = GlobalVariables.posterCache.object(forKey: movieId) {
            self.image = cachedImage
        } else {
            DispatchQueue.global(qos: .utility).async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image
                            
                            //Save to cache, remote poster image
                            GlobalVariables.posterCache.setObject(image, forKey: movieId)
                        }
                    }
                }
            }
            
        }
    }
    
    
}

