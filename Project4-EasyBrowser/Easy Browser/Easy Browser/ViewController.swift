//
//  ViewController.swift
//  Easy Browser
//
//  Created by Mostafa Hosseini on 9/19/23.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["www.apple.com", "www.hackingwithswift.com"]
    var selectedWebsite: String
    
    init(selectedWebsite: String) {
        self.selectedWebsite = selectedWebsite
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        setupToolbarAndNavBar()
        // the context value will be sent back whenever the value is changed (for checking which observer)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
    }

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            if websites.contains(host) {
                decisionHandler(.allow)
                return
            }
            let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .alert)
            alertController.title = "Blocked!"
            alertController.message = "This website is not in or whitelist"
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
            alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(alertController, animated: true)
        }
        decisionHandler(.cancel)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    private func setupWebView() {
        let url = URL(string: "https://\(selectedWebsite)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func setupToolbarAndNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let goBack = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: webView, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(image: UIImage(systemName: "arrow.forward"), style: .plain, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [goBack, goForward, spacer, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
    
    @objc private func openTapped() {
        let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        websites.forEach { website in
            alertController.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(alertController, animated: true)
    }
    
    private func openPage(action: UIAlertAction) {
        guard let website = action.title else { return }
        guard let url = URL(string: "https://\(website)") else { return }
        webView.load(URLRequest(url: url))
    }
    
}
