//
//  ImageService.swift
//  RepositoryExample
//
//  Created by Aleksey on 10/16/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit
import Alamofire

class ImageService {
    
    static let shared: ImageService = ImageService()
    private var cache = NSCache<NSURL, UIImage>()
    
    func loadImage(url: URL, completion: @escaping (_: UIImage?) -> Void) {
        
        if let image = cache.object(forKey: url as NSURL) {
            completion(image)
            return
        }
        
        request(url).responseData(completionHandler: { [weak self] response in
            guard let data: Data = response.data,
                let image: UIImage = UIImage(data: data) else { return }
            
            self?.cache.setObject(image, forKey: url as NSURL)
            completion(image)
        })
    }
}
