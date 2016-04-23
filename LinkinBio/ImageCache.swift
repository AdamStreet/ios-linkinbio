//
//  ImageCache.swift
//  LinkinBio
//
//  Created by Adam Szabo on 23/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

class ImageCache: NSCache {
	func cacheImage(image : UIImage, key : String) {
		self.setObject(image, forKey: key)
	}
	
	func cachedImage(key : String) -> UIImage? {
		return self.objectForKey(key) as? UIImage
	}
	
	static func keyForImageURL(imageURL : NSURL) -> String {
		return imageURL.absoluteString
	}
}
