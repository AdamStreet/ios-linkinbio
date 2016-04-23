//
//  PostsFetcher.swift
//  LinkinBio
//
//  Created by Adam Szabo on 22/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

typealias PostFetcherCompletion = (error : NSError?) -> Void

private let PostFetcherPostsKey : String = "posts"

class PostFetcher : NSObject {
	static let sharedFetcher : PostFetcher! = PostFetcher.init()
	
	lazy var fetchedResultsController : NSFetchedResultsController? = {
		var fetchedResultsController = PostEntityManager.fetchedResultsController([NSSortDescriptor.init(key: "scheduledTime", ascending: true)],
		                                                                          predicate: nil,
		                                                                          sectionNameKeyPath: nil,
		                                                                          cacheName: nil)
		do {
			try fetchedResultsController?.performFetch()
		} catch _ {
			fetchedResultsController = nil
		}
		
		return fetchedResultsController
	}()
	
	func updatePosts(completion : PostFetcherCompletion?) -> Request? {
		let request : Request = Alamofire.request(.GET, "https://app.latergram.me/api/pub/profiles.json?social_profile=latermedia", parameters: [:])
		
		request.responseJSON { response in
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
						
						let post = Post.insertedEntity(realPostMetadata)
						
						posts?.addObject(post!)
					})
				}
			}
			
			DatabaseManager.sharedManager.saveContext()
			
			completion?(error: response.result.error);
		}
		
		return request
	}
	
	func posts() -> [Post]? {
		return self.fetchedResultsController?.fetchedObjects as? [Post]
	}
}