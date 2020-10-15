//
//  BreedsModel.swift
//  RepositoryExample
//
//  Created by Mishko on 10/13/20.
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
    private var counter: PaginationCounter = PaginationCounter(itemsPerPage: 3,
                                                                         currentPage: 1, nextPage: 2)
    private var breeds: [CatBreed] = []
    private var service: BreedService = BreedService()
}

extension BreedsModel: BreedsInput {
    
    var breedsCount: Int {
        return breeds.count
    }
    
    func load() {
        guard !counter.isLoadingProceed else { return }
        counter.currentPage += 1
        
        service.loadAllBreeds(currentPage: counter.currentPage, breedsPerPage: counter.itemsPerPage, completion: { [weak self] newBreeds in
            self?.breeds.append(contentsOf: newBreeds)
            self?.counter.nextPage += 1
        })
    }
    
    func breedNameAt(index: Int)-> String? {
        return breeds.count < index ? breeds[index].name : nil
    }

}
