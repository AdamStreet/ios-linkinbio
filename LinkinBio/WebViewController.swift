//
//  WebViewController.swift
//  LinkinBio
//
//  Created by Ian MacKinnon on 2016-04-18.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

typealias WebViewControllerLoadingCompletion = () -> Void

class WebViewController: BaseViewController, UIWebViewDelegate {
	@IBOutlet var webView : UIWebView?
	
	var url : NSURL?
	var loadingCompletion : WebViewControllerLoadingCompletion?
	
	// MARK: Private methods
	
	func startLoadingURL() {
		self.webView?.loadRequest(NSURLRequest.init(URL: self.url!))
	}
	
	// MARK: view lifecycle
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		// TODO Show loading indicator
		
		self.startLoadingURL();
	}
	
	// MARK: <UIWebViewDelegate>
	
	func webViewDidFinishLoad(webView: UIWebView) {
		if (webView.loading == false) {
			self.loadingCompletion?()
		}
	}
}
