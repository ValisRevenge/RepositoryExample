//
//  DetailBreedModel.swift
//  RepositoryExample
//
//  Created by Mishko on 10/15/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit
import EventsTree

protocol DetailBreedInput {
    var title: String? {get}
    var detailBreed: DetailBreedDisplayable {get}
    var photosCount: Int { get }
    func load()
    func urlAt(index: Int)-> URL?
}

protocol DetailBreedOutput: class {
    func reload()
}

class DetailBreedModel: EventNode {
    
    private var breed: CatBreed!
    private var photos: [Photo] = []
    
    weak var output: DetailBreedOutput!
    
    init(parent: EventNode?, breed: CatBreed) {
        super.init(parent: parent)
        
        self.breed = breed
    }
}

extension DetailBreedModel: DetailBreedInput {
    
    var photosCount: Int {
        return photos.count
    }
    
    var title: String? {
        return breed.name
    }
    
    var detailBreed: DetailBreedDisplayable {
        return DetailBreedDisplayable(rare: String(breed.rare),
            lifeTime: breed.lifeSpan,
            hairless: breed.hairless,
            temperament: breed.temperament,
            origin: breed.origin,
            intelligence: breed.intelligence.name)
    }
    
    func load() {
        BreedService().loadBreedImages(breedId: breed.id,
                                       page: 0,
                                       itemsPerPage: 5,
                                       completion: { [weak self] newPhotos in
            self?.photos.append(contentsOf: newPhotos)
            self?.output.reload()
        })
    }
    
    func urlAt(index: Int) -> URL? {
        return photos[index].url
    }
}
