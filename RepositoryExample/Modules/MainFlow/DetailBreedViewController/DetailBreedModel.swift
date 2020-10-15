//
//  DetailBreedModel.swift
//  RepositoryExample
//
//  Created by Mishko on 10/15/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit
import EventsTree

protocol DetailBreedInput {}

class DetailBreedModel: EventNode {
    
    private var breed: CatBreed!
    
    init(parent: EventNode?, breed: CatBreed) {
        super.init(parent: parent)
        
        self.breed = breed
    }
}

extension DetailBreedModel: DetailBreedInput {
    
}
