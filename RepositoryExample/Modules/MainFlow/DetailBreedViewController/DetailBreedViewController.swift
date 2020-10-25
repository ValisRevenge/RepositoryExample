//
//  DetailBreedViewController.swift
//  RepositoryExample
//
//  Created by Mishko on 10/15/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit

final class DetailBreedViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var rareLabel: UILabel!
    @IBOutlet private weak var lifeLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var hairlessLabel: UILabel!
    @IBOutlet private weak var temperamentLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!

    var model: DetailBreedInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        model.load()
    }
    
    private func setup() {
        
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        title = model.title
        
        let breed = model.detailBreed
        
        rareLabel.text = "Rare: " + breed.rare
        lifeLabel.text = "Lifespan: " + (breed.lifeTime ?? "no info")
        originLabel.text = "Origin: " + breed.origin
        hairlessLabel.text = "Hairless: " + String(breed.hairless)
        temperamentLabel.text = "Temperament: " + breed.temperament
        weightLabel.text = "Intelligence: " + breed.intelligence
    }

}

extension DetailBreedViewController: DetailBreedOutput {
    
    func reload() {
        tableView.reloadData()
    }
}

extension DetailBreedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.photosCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PhotoCell,
            let url = model.urlAt(index: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.setup(url: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
