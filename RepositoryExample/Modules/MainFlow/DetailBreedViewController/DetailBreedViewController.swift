//
//  DetailBreedViewController.swift
//  RepositoryExample
//
//  Created by Mishko on 10/15/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit

class DetailBreedViewController: UIViewController {
    
    @IBOutlet weak var breedImageView: UIImageView!
    
    @IBOutlet weak var rareLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var hairlessLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!

    var model: DetailBreedInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        title = model.title
        
        let breed = model.detailBreed
        
        rareLabel.text = "Rare: " + breed.rare
        lifeLabel.text = "Lifespan: " + (breed.lifeTime ?? "no info")
        originLabel.text = "Origin: " + breed.origin
        hairlessLabel.text = "Hairless: " + String(breed.hairless)
        temperamentLabel.text = "Temperament: " + breed.temperament
        weightLabel.text = "Weight: " + (breed.weight ?? "no info")
    }

}
