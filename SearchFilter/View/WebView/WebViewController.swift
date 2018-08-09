//
//  WebViewController.swift
//  IsmayaApp
//
//  Created by Ibrahim Indosystem on 10/13/17.
//  Copyright © 2017 Indosytem. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class Interceptor: URLProtocol {
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest  {
        return request
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        // returns true for the requests we want to intercept (*.png)
        return ["jpg", "jpeg", "png", "gif"].contains(request.url!.pathExtension)
    }
    
    override func startLoading() {
        // a request for a png file starts loading
        // custom response
        
        
        let response = URLResponse(url: request.url!, mimeType: "image/*", expectedContentLength: -1, textEncodingName: nil)
        
        if let client = self.client {
            client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            // reply with data from a local file
            
            guard let data = NSData(contentsOfFile: "local file path") else {
                client.urlProtocolDidFinishLoading(self)
                return
            }
            
            client.urlProtocol(self, didLoad: data as Data)
            
            client.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {
    }
}

class WebViewController: UIViewController,WKUIDelegate,WKNavigationDelegate{
    
    var webUrl = ""
    @IBOutlet weak var webViewContainer: UIView!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLProtocol.registerClass(Interceptor.self)
        
        self.navigationController?.isNavigationBarHidden = false
        
        let webConfiguration = WKWebViewConfiguration()
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.webViewContainer.frame.size.height))
        self.webView = WKWebView (frame: customFrame , configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webViewContainer.addSubview(webView)
        webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: webViewContainer.rightAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: webViewContainer.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor).isActive = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        if let myURL = URL(string: webUrl){
            let myRequest = URLRequest(url: myURL)
            
            webView.load(myRequest)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        LoadingOverlay.shared.hideOverlay()
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        LoadingOverlay.shared.showOverlay()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadingOverlay.shared.hideOverlay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
