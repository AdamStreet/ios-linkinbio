//
//  ThumbCollectionViewCell.swift
//  LinkinBio
//
//  Created by Adam Szabo on 22/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

let ThumbCollectionViewCellIdentifier : String = "ThumbCollectionViewCellIdentifier"

class ThumbCollectionViewCell: UICollectionViewCell {
	@IBOutlet var loadableImageView : LoadableImageView?
	
	@IBOutlet var titleLabel : UILabel?
	
	private var kvoContext = 0
	
	var post : Post? {
		willSet {
			self.post?.removeObserver(self, forKeyPath: "seen")
		}
		
		didSet {
			self.post?.addObserver(self,
			                       forKeyPath: "seen",
			                       options: NSKeyValueObservingOptions.New,
			                       context: &kvoContext)
			
			self.loadableImageView?.setImageURL(self.post?.thumbnailURL(), completion : nil)
			self.titleLabel?.text = self.post?.postLinkURL()?.host
			
			self.updateVisibility()
		}
	}
	
	// MARK: Private methods
	
	func updateVisibility() {
		if (post == nil || post?.seen == true) {
			self.loadableImageView?.alpha = 0.5
			self.titleLabel?.textColor = UIColor.grayColor()
		} else {
			self.loadableImageView?.alpha = 1.0;
			self.titleLabel?.textColor = UIColor.blackColor()
		}
	}
	
	// MARK: KVO
	
	override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
		if context != &kvoContext {
			super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
			
			return
		}
		
		self.updateVisibility()
	}
}
