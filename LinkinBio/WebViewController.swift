//
//  WebViewController.swift
//  LinkinBio
//
//  Created by Ian MacKinnon on 2016-04-18.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
	@IBOutlet var webView : UIWebView?
	
	var url : NSURL?
	
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
}
