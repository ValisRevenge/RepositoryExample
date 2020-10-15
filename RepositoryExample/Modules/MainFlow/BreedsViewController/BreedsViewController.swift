//
//  BreedsViewController.swift
//  RepositoryExample
//
//  Created by Mishko on 10/13/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit

final class BreedsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: BreedsInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        model.load()
    }

}
