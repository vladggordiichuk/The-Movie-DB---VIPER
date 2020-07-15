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
        
        let nsString = NSString(string: url.absoluteString)
        
        if let cachedImage = hasImageCached(for: nsString) {
            completion(cachedImage)
        } else {
            
            onBeginLoading()
            
            let urlTask = NetworkManager.shared.loadImage(with: url) { [weak imageView] (result: Result<Data>) in
                                
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)!
                    ImageCacheService.shared.cache.setObject(image, forKey: nsString)
                    completion(image)
                case .failure(let error):
                    guard error != .requestCanceled, let imageView = imageView else { return }
                    ImageCacheService.getImage(for: imageView, with: url, onBeginLoading: onBeginLoading, completion: completion)
                }
            }
            
            ImageCacheService.shared.request[imageView] = urlTask
        }
    }
    
    static func cancelGetImage(for imageView: UIImageView) {
        
        if let urlTask = ImageCacheService.shared.request[imageView] {
            urlTask.suspend()
            urlTask.cancel()
            ImageCacheService.shared.request[imageView] = nil
        }
    }
}

extension LoadableImageView {
    
    func setImage(with url: URL?) {
        
        guard let url = url else { return }
        
        image = nil
        
        ImageCacheService.getImage(for: self, with: url, onBeginLoading: { [weak self] in
            DispatchQueue.main.async {
                self?.showActivityIndicator()
            }
        }) { [weak self] image in
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                self?.image = image
            }
        }
    }
    
    func cancelSetImage() {
        ImageCacheService.cancelGetImage(for: self)
    }
}
