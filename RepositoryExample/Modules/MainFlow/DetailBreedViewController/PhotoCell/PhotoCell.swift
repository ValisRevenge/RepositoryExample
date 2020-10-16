//
//  PhotoCell.swift
//  RepositoryExample
//
//  Created by Mishko on 10/16/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet private weak var catImageView: UIImageView!
    @IBOutlet private weak var spinnerView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        catImageView.image = nil
    }
    
    func setup(url: URL) {
        spinnerView.startAnimating()
        spinnerView.isHidden = false
        ImageService.shared.loadImage(url: url, completion: { [weak self] image in
            self?.catImageView.image = image
            self?.spinnerView.isHidden = true
        })
    }
    
}
