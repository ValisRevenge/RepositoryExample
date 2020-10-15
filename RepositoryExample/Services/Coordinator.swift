//
//  Coordinator.swift
//  RepositoryExample
//
//  Created by Aleksey on 10/13/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit
import EventsTree

class FlowCoordinator: EventNode {
        
    var root: UINavigationController!
    
    func startFlow() -> UIViewController {
        return UIViewController()
    }
}
