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
    func hideSpinner()
}

final class BreedsModel: EventNode {
    
    private var counter: PaginationCounter =
        PaginationCounter(itemsPerPage: 9)
    private var breeds: [CatBreed] = []
    private var repository: BreedRepository = LocalRepository()
    
    weak var output: BreedsOutput!
}

extension BreedsModel: BreedsInput {
    
    var breedsCount: Int {
        return breeds.count
    }
    
    func breedAt(index: Int) -> BreedDisplayable? {
        return BreedDisplayable(name: breeds[index].name, description: breeds[index].temperament)
    }
    
    func load() {
        guard !counter.isLoadingProceed else {
            return
        }
        
        guard !self.counter.isLimitReached else {
            output.hideSpinner()
            return
        }
        counter.isLoadingProceed = true
        counter.currentPage += 1
        
        repository.getAt(startPage: counter.currentPage-1, count: counter.itemsPerPage) { [weak self] newBreeds in
            
            guard let `self` = self else { return }
            
            self.breeds.append(contentsOf: newBreeds)
            self.counter.isLoadingProceed.toggle()

            if newBreeds.count == 0 && self.repository is LocalRepository {
                self.repository = WebRepository()
                self.load()
                return
            } else {
                DBManager.shared.saveDefault()
            }
            self.counter.isLimitReached = newBreeds.count == 0
            self.output.reload()
        }
    }
    
    func openBreed(index: Int) {
        raise(event: BreedsEvent.openDetailBreed(breed: breeds[index]))
    }
}
