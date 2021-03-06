//
//  WebRepository.swift
//  RepositoryExample
//
//  Created by Mishko on 10/19/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation
import Alamofire

class BreedWebService: BreedService {
    
    func loadBreedImages(breedId: String,
                         page: Int,
                         itemsPerPage: Int,
                         completion: @escaping ([Photo]) -> Void) {
        let api = BreedAPI.imagesBy(breedId: breedId, page: page, limit: itemsPerPage)
        
        request(api.url,
                method: .get,
                parameters: api.params,
                encoding: api.encoding,
                headers: api.headers).responseData(completionHandler: { response in
                    guard let data = response.data else {
                        return
                    }
                    
                    do {
                        let photos = try JSONDecoder().decode([Photo].self, from: data)
                        completion(photos)
                    }
                    catch(let error) {
                        print(error.localizedDescription)
                    }
        })
    }
    
    func getAll(completion: @escaping ([CatBreed]) -> Void) {
        let api = BreedAPI.allBreeds(page: nil, limit: nil)
        
        request(api.url,
                method: .get,
                parameters: api.params,
                encoding: api.encoding,
                headers: api.headers).responseData(completionHandler: { response in
                    guard let data = response.data else {
                        return
                    }
                    
                    do {
                        let breeds = try JSONDecoder().decode([CatBreed].self, from: data)
                        completion(breeds)
                    }
                    catch(let error) {
                        print(error.localizedDescription)
                    }
        })
    }
    
    func getAt(startPage: Int, count: Int, completion: @escaping ([CatBreed]) -> Void) {
        
        let api = BreedAPI.allBreeds(page: startPage, limit: count)
        
        request(api.url,
                method: .get,
                parameters: api.params,
                encoding: api.encoding,
                headers: api.headers).responseData(completionHandler: { response in
                    guard let data = response.data else {
                        return
                    }
                    
                    do {
                        let breeds = try JSONDecoder().decode([CatBreed].self, from: data)
                        completion(breeds)
                    }
                    catch(let error) {
                        print(error.localizedDescription)
                    }
        })
    }
    
    func removeAll() {}
}
