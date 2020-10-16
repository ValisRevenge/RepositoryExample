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
    private var cache: [URL: UIImage?] = [:]
    
    func loadImage(url: URL, completion: @escaping (_: UIImage?) -> Void) {
        
        if let image = cache[url] {
            completion(image)
            print("used_cache")
            return
        }
        
        request(url).responseData(completionHandler: { [weak self] response in
            guard let data = response.data else { return}
            
            let image: UIImage? = UIImage(data: data)
            self?.cache[url] = image
            completion(image)
        })
    }
}
