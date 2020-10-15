//
//  BreedService.swift
//  RepositoryExample
//
//  Created by Mishko on 10/15/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation
import Alamofire

final class BreedService {
    
    func loadAllBreeds(currentPage: Int, breedsPerPage: Int, completion: @escaping (_: [CatBreed]) -> Void) {
        let api = BreedAPI.allBreeds(page: currentPage,
                                     limit: breedsPerPage)
        
        request(api.url, method: .get, parameters: api.params, encoding: api.encoding, headers: api.headers).responseData(completionHandler: { response in
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
    
    func loadBreedImages() {
        
    }
}
