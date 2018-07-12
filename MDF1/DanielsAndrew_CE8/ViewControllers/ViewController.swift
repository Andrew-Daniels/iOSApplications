//
//  ViewController.swift
//  DanielsAndrew_CE8
//
//  Created by Andrew Daniels on 1/20/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    // Mark: - IBActions
    //These IBActions handle
    //Go back
    //go forward
    //and reload page actions
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    //IBOutlets and variables
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var forwardBtn: UIBarButtonItem!
    var webView = WKWebView()
    
    //Create webview that goes to google.com address
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.frame)
        if let url1 = URL(string: "https://google.com") {
            webView.load(URLRequest(url: url1))
        }
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view.addSubview(webView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - WKNavigationDelegate
    //Print a error to console if the webview fails to navigate
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebView failed with error: \(error)")
    }

    //When the webview finishes navigating to a page check if user can
    //go back
    //go forward
    //enable/disable buttons as so
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.canGoBack {
            //make go back button usable
            backBtn.isEnabled = true
        } else {
            backBtn.isEnabled = false
        }
        if webView.canGoForward {
            //make go forward button usable
            forwardBtn.isEnabled = true
        } else {
            forwardBtn.isEnabled = false
        }
    }
}

