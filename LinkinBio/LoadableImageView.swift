//
//  LoadableImageView.swift
//  LinkinBio
//
//  Created by Adam Szabo on 22/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit
import Alamofire

typealias LoadableImageViewCompletion = (image : UIImage?, error : NSError?) -> Void

class LoadableImageView: LoadingView {
	private(set) var imageView : UIImageView!
	
	private var pendingRequest : Request?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let imageView = UIImageView.init(frame: self.bounds)
		imageView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
		imageView.contentMode = .ScaleAspectFill
		self.addSubview(imageView)
		self.imageView = imageView
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		if (self.imageView == nil) {
			let imageView = UIImageView.init(frame: self.bounds)
			imageView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
			imageView.contentMode = .ScaleAspectFill
			self.addSubview(imageView)
			self.imageView = imageView
		}
	}
	
	// MARK: Private methods
	
	private func showImage(image : UIImage?, animated : Bool) {
		// TODO Handle `animated` property
		
		self.imageView.image = image
	}
	
	private func setLoadingIndicatorVisible(visible: Bool) {
		self.imageView.hidden = visible
		
		if (visible) {
			self.activityIndicatorView.startAnimating()
		} else {
			self.activityIndicatorView.stopAnimating()
		}
	}
	
	// MARK: Public methods
	
	func clear() {
		self.imageView.image = nil;
		
		self.pendingRequest?.cancel()
	}
	
	func setImageURL(imageURL : NSURL!, completion : LoadableImageViewCompletion?) {
		self.clear()
		
		self.setLoadingIndicatorVisible(true)
		
		self.pendingRequest = ImageFetcher.sharedFetcher.fetchImage(imageURL) { (image, error) in
			self.setLoadingIndicatorVisible(false)
			
			self.showImage(image, animated: true)
		}
	}
}
