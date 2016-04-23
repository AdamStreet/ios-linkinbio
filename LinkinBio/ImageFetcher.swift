//
//  ImageFetcher.swift
//  LinkinBio
//
//  Created by Adam Szabo on 22/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

import Alamofire

typealias ImageFetcherCompletion = (image : UIImage?, error : NSError?) -> Void

class ImageFetcher: NSObject {
	static let sharedFetcher : ImageFetcher! = ImageFetcher.init()
	
	let imageCache : ImageCache! = ImageCache.init()
	
	func fetchImage(imageURL : NSURL!, completion : ImageFetcherCompletion?) -> Request? {
		let cacheKey = ImageCache.keyForImageURL(imageURL)
		
		if let image = imageCache.cachedImage(cacheKey) {
			completion?(image: image, error: nil)
		}
		
		let request : Request = Alamofire.request(.GET, imageURL.absoluteString)
		request.responseData { (response : Response<NSData, NSError>) in
			var image : UIImage? = nil
			if (response.result.value != nil) {
				image = UIImage.init(data: response.result.value!)
				
				self.imageCache.cacheImage(image!, key: cacheKey)
			}
			
			completion?(image: image, error: response.result.error)
		}
		
		return request
	}
}
