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
	
	func fetchImage(imageURL : NSURL!, completion : ImageFetcherCompletion?) {
		Alamofire.request(.GET, imageURL.absoluteString).responseData { (response : Response<NSData, NSError>) in
			var image : UIImage? = nil
			if (response.result.value != nil) {
				image = UIImage.init(data: response.result.value!)
			}
			
			// TODO Cache image (if needed: at the moment, Alamofire does the job)
			
			completion?(image: image, error: response.result.error)
		}
	}
}
