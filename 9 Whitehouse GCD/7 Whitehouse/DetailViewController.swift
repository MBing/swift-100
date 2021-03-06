//
//  DetailViewController.swift
//  7 Whitehouse
//
//  Created by Martin Demiddel on 08.04.19.
//  Copyright © 2019 Martin Bing. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }

        let html = """
            <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style>
                    body {
                        font-size: 150%;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                    }
                </style>
            </head>
            <body>
                <div>\(detailItem.body)</div>
            </body>
            </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
