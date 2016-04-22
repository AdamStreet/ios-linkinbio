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
	
	var post : Post? {
		didSet {
			self.loadableImageView?.setImageURL(self.post?.thumbURL, completion : nil)
			self.titleLabel?.text = self.post?.linkURL.host
		}
	}
}
