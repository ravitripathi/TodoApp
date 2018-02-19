//
//  ViewController2.swift
//  TodoApp
//
//  Created by Ravi Tripathi on 19/02/18.
//  Copyright © 2018 Ravi Tripathi. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController2: UIViewController, UIWebViewDelegate  {
    //MARK: - Lifecycle Methods

    var webView: UIWebView!
    
    @IBAction func profileTap(_ sender: UITapGestureRecognizer) {
        print("Profile tapped")
        webView = UIWebView(frame: UIScreen.main.bounds)
        webView.delegate = self
        view.addSubview(webView)
        if let url = URL(string: "http://github.com/ravitripathi") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
     }
    @IBOutlet weak var linkStack: UIStackView!
    
    let url = URL(string: "https://graph.facebook.com/1171385879556730/picture?type=large")!
    
    @IBOutlet weak var profilePic: UIImageView!
    
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
        profilePic.kf.setImage(with: url)
    }
}



