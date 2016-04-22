//
//  PostsFetcher.swift
//  LinkinBio
//
//  Created by Adam Szabo on 22/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import Foundation
import Alamofire

typealias PostFetcherCompletion = (posts : [Post]?) -> Void

private let PostFetcherPostsKey : String = "posts"

class PostFetcher : NSObject {
	static let sharedFetcher : PostFetcher! = PostFetcher.init()
	
	func fetchPosts(completion : PostFetcherCompletion?) {
		Alamofire.request(.GET, "https://app.latergram.me/api/pub/profiles.json?social_profile=latermedia", parameters: [:])
			.responseJSON { response in
				print(response.request)  // original URL request
				print(response.result)     // server data
				
				let jsonResponse : [String : AnyObject]? = response.result.value as? [String : AnyObject]
				
				var posts : NSMutableArray? = nil
				
				if (jsonResponse != nil) {
					print("Response: \(jsonResponse)")
					
					let postsMetadatas : NSArray? = jsonResponse![PostFetcherPostsKey] as? NSArray

					if (postsMetadatas != nil) {
						posts = NSMutableArray.init(capacity: postsMetadatas!.count)
						
						postsMetadatas!.enumerateObjectsUsingBlock({ (postMetadata : AnyObject, index : Int, stop : UnsafeMutablePointer<ObjCBool>) in
							let realPostMetadata = postMetadata as! [String : AnyObject]
							
							let post = Post.init(metadata: realPostMetadata)
							
							posts?.addObject(post)
						})
					}
				}
				
				if (completion != nil) {
					completion!(posts: posts?.copy() as? [Post]);
				}
		}
	}
}