//
//  LoadableImageView.swift
//  LinkinBio
//
//  Created by Adam Szabo on 22/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

typealias LoadableImageViewCompletion = (image : UIImage?, error : NSError?) -> Void

class LoadableImageView: UIView {
	private(set) var imageView : UIImageView!
	
	func sharedInit() {
		let imageView = UIImageView.init(frame: self.bounds)
		imageView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
		imageView.contentMode = .ScaleAspectFill
		self.addSubview(imageView)
		self.imageView = imageView
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.sharedInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.sharedInit()
	}
	
	// MARK: Privat methods
	
	private func showImage(image : UIImage?, animated : Bool) {
		// TODO Handle `animated` property
		
		self.imageView.image = image
	}
	
	// MARK: Public methods
	
	func clear() {
		self.imageView.image = nil;
	}
	
	func setImageURL(imageURL : NSURL!, completion : LoadableImageViewCompletion?) {
		self.clear()
		
		// TODO Show loading indicator
		
		ImageFetcher.sharedFetcher.fetchImage(imageURL) { (image, error) in
			self.showImage(image, animated: true)
		}
	}
}
