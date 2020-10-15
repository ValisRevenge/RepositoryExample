//
//  MainFlowCoordinator.swift
//  RepositoryExample
//
//  Created by Mishko on 10/13/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit
import EventsTree

class MainFlowCoordinator: FlowCoordinator {
    
    override init(parent: EventNode?) {
        super.init(parent: parent)
        
        addHandler { [weak self] (event: BreedsEvent) in
            switch event {
            case .openDetailBreed(let breed):
                self?.presentDetailBreed(breed: breed)
            }
        }
    }
    
    override func startFlow() -> UIViewController {
        let breedsVC = BreedsViewController(nibName: "BreedsViewController", bundle: nil)
        breedsVC.model = BreedsModel(parent: self)
        
        let navigationVC = UINavigationController(rootViewController: breedsVC)
        root = navigationVC
        
        return navigationVC
    }
}

extension MainFlowCoordinator {
    
    func presentDetailBreed(breed: CatBreed) {
        let detailBreedVC = DetailBreedViewController(nibName: "DetailBreedViewController", bundle: nil)
        let model = DetailBreedModel(parent: self, breed: breed)
        
        detailBreedVC.model = model
        
        root.pushViewController(detailBreedVC, animated: true)
    }
    
}
