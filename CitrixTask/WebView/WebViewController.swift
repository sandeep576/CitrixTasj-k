//
//  WebViewController.swift
//  CitrixTask
//
//  Created by Sai Sandeep on 02/07/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var urlString: String = ""

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebViewContent()
    }

    func loadWebViewContent() {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
