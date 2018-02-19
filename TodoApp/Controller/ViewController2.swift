//
//  ViewController2.swift
//  TodoApp
//
//  Created by Ravi Tripathi on 19/02/18.
//  Copyright © 2018 Ravi Tripathi. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    //MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        print("2: viewWillAppear: Disappeared -> Appearing or Disappearing -> Appearing")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("2: viewDidAppear: Appearing -> Appeared")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("2: viewWillDisappear: Appeared -> Disappearing or Appearing -> Disappearing")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("2: viewDidDisappear: Disappearing -> Disappeared")
    }
    
    
    override func viewDidLoad() {
         print("2: viewDidLoad")
    }
    
        
}

