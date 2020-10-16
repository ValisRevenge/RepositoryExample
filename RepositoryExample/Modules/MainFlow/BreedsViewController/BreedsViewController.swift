//
//  BreedsViewController.swift
//  RepositoryExample
//
//  Created by Mishko on 10/13/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit

final class BreedsViewController: UIViewController {
    
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var model: BreedsInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        model.load()
        setup()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: String(describing: BreedCell.self), bundle: nil), forCellReuseIdentifier: "cell")
        
        title = "Breeds"
    }

}

extension BreedsViewController: BreedsOutput {
    
    func reload() {
        tableView.reloadData()
        spinnerView.isHidden = true
    }
}

extension BreedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.breedsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BreedCell else {
            return UITableViewCell()
        }
        
        if let breed = model.breedAt(index: indexPath.row) {
            cell.setup(breed: breed)
        }
        return cell
    }
}

extension BreedsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.openBreed(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= model.breedsCount - 2 {
            model.load()
            spinnerView.isHidden = false
        }
    }
}
