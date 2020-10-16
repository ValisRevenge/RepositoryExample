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
    func breedAt(index: Int)-> BreedDisplayable?
    func load()
    func openBreed(index: Int)
}
protocol BreedsOutput: class {
    
    func reload()
}

final class BreedsModel: EventNode {
    
    private var counter: PaginationCounter =
        PaginationCounter(itemsPerPage: 7)
    private var breeds: [CatBreed] = []
    private var service: BreedService = BreedService()
    
    weak var output: BreedsOutput!
}

extension BreedsModel: BreedsInput {
    
    var breedsCount: Int {
        return breeds.count
    }
    
    func breedAt(index: Int)-> BreedDisplayable? {
        return BreedDisplayable(name: breeds[index].name, description: breeds[index].temperament)
    }
    
    func load() {
        guard !counter.isLoadingProceed, !self.counter.isLimitReached else { return }
        counter.isLoadingProceed = true
        print(counter.isLoadingProceed)
        counter.currentPage += 1
        
        service.loadAllBreeds(currentPage: counter.currentPage, breedsPerPage: counter.itemsPerPage, completion: { [weak self] newBreeds in
            
            guard let `self` = self else { return }
            
            self.breeds.append(contentsOf: newBreeds)
            self.counter.isLimitReached = newBreeds.count == 0
            self.counter.isLoadingProceed.toggle()
            self.output.reload()
        })
    }
    
    func openBreed(index: Int) {
        raise(event: BreedsEvent.openDetailBreed(breed: breeds[index]))
    }

}
