//
//  PostEntityDatabaseManager.swift
//  LinkinBio
//
//  Created by Adam Szabo on 23/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit
import CoreData

class PostEntityManager: NSObject {
	static let databaseManager = DatabaseManager.sharedManager
	
	class func fetchPost(postId : NSNumber!, profileId : NSNumber!, createIfNotExist : Bool) -> Post? {
		let fetchRequest = NSFetchRequest.init(entityName: "Post")
		fetchRequest.predicate = NSPredicate.init(format: "postId == %@ && profileId == %@", postId, profileId)
		fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "scheduledTime", ascending: true)]
		
		var result : [AnyObject]? = nil
		do {
			result = try databaseManager.managedObjectContext.executeFetchRequest(fetchRequest)
		} catch _ {
			result = nil
		}
		
		var post : Post? = result?.first as? Post
		
		if (post == nil && createIfNotExist) {
			post = PostEntityManager.createPost(postId, profileId: profileId)
		}
		
		return post
	}
	
	class func createPost(postId : NSNumber!, profileId : NSNumber!) -> Post! {
		let post : Post = NSEntityDescription.insertNewObjectForEntityForName("Post", inManagedObjectContext: databaseManager.managedObjectContext) as! Post
		
		post.postId = postId
		post.profileId = profileId
		
		return post
	}
	
	class func fetchedResultsController(sortDescriptors : [NSSortDescriptor]!, predicate : NSPredicate?,
	                                    sectionNameKeyPath : String?, cacheName : String?) -> NSFetchedResultsController? {
		let request = NSFetchRequest.init(entityName: "Post")
		request.sortDescriptors = sortDescriptors
		request.predicate = predicate
		
		return NSFetchedResultsController.init(fetchRequest: request,
		                                       managedObjectContext: self.databaseManager.managedObjectContext,
		                                       sectionNameKeyPath: sectionNameKeyPath,
		                                       cacheName: cacheName)
	}
}
