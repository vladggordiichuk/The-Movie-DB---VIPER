//
//  ImageCacheService.swift
//  The Movie DB
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class ImageCacheService {
    
    static let shared = ImageCacheService()
    
    let cache = NSCache<NSString, UIImage>()
    
    var request = [UIImageView : URLSessionTask]()
    
    static func hasImageCached(for nsString: NSString) -> UIImage? {
        return ImageCacheService.shared.cache.object(forKey: nsString)
    }
    
    static func getImage(for imageView: UIImageView, with url: URL, onBeginLoading: @escaping () -> Void, completion: @escaping (UIImage) -> Void) {
        
        print(ImageCacheService.shared.request[imageView]?.state)
        
        ImageCacheService.cancelGetImage(for: imageView)
        
        let nsString = NSString(string: url.absoluteString)
        
        if let cachedImage = hasImageCached(for: nsString) {
            completion(cachedImage)
        } else {
            
            onBeginLoading()
            
            let urlTask = NetworkManager.shared.loadImage(with: url) { (result: Result<Data>) in
                
                //ImageCacheService.shared.request[imageView] = nil
                
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)!
                    ImageCacheService.shared.cache.setObject(image, forKey: nsString)
                    completion(image)
                case .failure(let error): print(error.localizedDescription)
                }
            }
            
            ImageCacheService.shared.request[imageView] = urlTask
        }
    }
    
    static func cancelGetImage(for imageView: UIImageView) {
        
//        ImageCacheService.shared.request[imageView]?.cancel()
//        ImageCacheService.shared.request[imageView] = nil
    }
}

extension UIImageView {
    
    func setImage(with url: URL?) {
        
        guard let url = url else { return }
        
        ImageCacheService.getImage(for: self, with: url, onBeginLoading: { [weak self] in
            DispatchQueue.main.async {
                self?.image = UIImage(named: "Raw-Image")
            }
        }) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    func cancelSetImage() {
        ImageCacheService.cancelGetImage(for: self)
    }
}
