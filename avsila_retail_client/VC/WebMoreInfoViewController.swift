//
//  WebMoreInfoViewController.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 24.12.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit
import WebKit

class WebMoreInfoViewController: UIViewController {
    let  webViewFrame = WKWebView()
    
    override func viewDidLoad() {
        if let myURL = URL(string: "http://avsila.ru") {
                          let request = URLRequest(url: myURL)
                           webViewFrame.load(request)
                         }
        view.addSubview(webViewFrame)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webViewFrame.frame = view.bounds
    }

}
