//
//  BreedsModel.swift
//  RepositoryExample
//
//  Created by Aleksey on 10/13/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation
import EventsTree
import Alamofire

enum BreedsEvent: Event {
    case openDetailBreed(breed: CatBreed)
}

protocol BreedsInput {
    
    var breedsCount: Int { get }
    func breedNameAt(index: Int)-> String?
    func load()
}
protocol BreedsOutput {}

final class BreedsModel: EventNode {
    private var paginationCounter: PaginationCounter = PaginationCounter(itemsPerPage: 10, currentPage: 1)
    private var breeds: [CatBreed] = []
}

extension BreedsModel: BreedsInput {
    
    var breedsCount: Int {
        return breeds.count
    }
    
    func load() {
        
        let api = BreedAPI.allBreeds(page: paginationCounter.currentPage,
                                     limit: paginationCounter.currentPage)
        
        request(api.url, method: .get, parameters: api.params, encoding: api.encoding, headers: api.headers).responseJSON(completionHandler: { [weak self] response in
            
        })
    }
    
    func breedNameAt(index: Int)-> String? {
        return breeds.count < index ? breeds[index].name : nil
    }

}
