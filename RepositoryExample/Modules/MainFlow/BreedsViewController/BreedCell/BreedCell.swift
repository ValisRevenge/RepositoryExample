//
//  BreedCell.swift
//  RepositoryExample
//
//  Created by Mishko on 10/16/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit

class BreedCell: UITableViewCell {
    
    @IBOutlet private weak var nameLable: UILabel!
    @IBOutlet private weak var decriptionLabel: UILabel!
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
    
    func setup(breed: BreedDisplayable) {
        nameLable.text = breed.name
        decriptionLabel.text = breed.description
    }
}
