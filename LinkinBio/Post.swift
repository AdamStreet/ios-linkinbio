//
//  Post.swift
//  
//
//  Created by Adam Szabo on 23/04/2016.
//
//

import Foundation
import CoreData

/*
Example:
... {
caption = "Calling \Ud83d\Udce3 all bloggers: we put together 11 easy ways to make your blog look amazing on social media! It only takes a few little changes to have a BIG impact. Link in bio! \U270c\Ud83c\Udffe #latergramme";
"created_time" = 1457073541;
"gram_type" = image;
id = 5409526;
"image_url" = "https://lg-image-prod.s3.amazonaws.com/instagram/617681ae1569cd9cdfb7cf54.jpg?1457073547";
"link_url" = "http://blog.latergram.me/how-to-make-your-blog-look-amazing-on-social-media/";
"profile_id" = 32192;
"scheduled_time" = 1457196300;
"thumb_url" = "https://lg-image-prod.s3.amazonaws.com/sized/617681ae1569cd9cdfb7cf54/small_thumbnail.jpg?1457073579";
"video_url" = "<null>";
}, ...
*/
private let PostKeyPostIdKey : String = "id"
private let PostKeyCreatedTimeKey : String = "created_time"
private let PostKeyImageURLStringKey : String = "image_url"
private let PostKeyThumbURLStringKey : String = "thumb_url"
private let PostKeyLinkURLStringKey : String = "link_url"
private let PostKeyVideoURLKey : String = "video_url"
private let PostKeyPostTypeKey : String = "gram_type"
private let PostKeyCaptionKey : String = "caption"
private let PostKeyScheduledTimeKey : String = "scheduled_time"
private let PostKeyProfileIdKey : String = "profile_id"

class Post: NSManagedObject {
	
	
	
	class func insertedEntity(metadata : [String : AnyObject]) -> Post? {
		let post : Post? = PostEntityManager.fetchPost(metadata[PostKeyPostIdKey] as! NSNumber,
		                                               profileId: metadata[PostKeyProfileIdKey] as! NSNumber,
		                                               createIfNotExist: true)
		
		post?.creationTime = metadata[PostKeyCreatedTimeKey] as? NSNumber
		post?.imageURLString = metadata[PostKeyImageURLStringKey] as? String
		post?.thumbnailURLString = metadata[PostKeyThumbURLStringKey] as? String
		post?.linkURLString = metadata[PostKeyLinkURLStringKey] as? String
		post?.scheduledTime = metadata[PostKeyScheduledTimeKey] as? NSNumber
		post?.videoURLString = metadata[PostKeyVideoURLKey] as? String
		post?.postTypeString = metadata[PostKeyPostTypeKey] as? String
		post?.caption = metadata[PostKeyCaptionKey] as? String
		
		return post
	}

	// MARK: Public methods
	
	func createdAt() -> NSDate? {
		if (self.creationTime == nil) {
			return nil;
		}
		
		return NSDate.init(timeIntervalSince1970: self.creationTime!.doubleValue)
	}
	
	func imageURL() -> NSURL? {
		if (self.imageURLString == nil) {
			return nil
		}
		
		return NSURL.init(string: self.imageURLString!)
	}

	func thumbnailURL() -> NSURL? {
		if (self.thumbnailURLString == nil) {
			return nil
		}
		
		return NSURL.init(string: self.thumbnailURLString!)
	}
	
	func postLinkURL() -> NSURL? {
		if (self.linkURLString == nil) {
			return nil
		}
		
		return NSURL.init(string: self.linkURLString!)
	}
	
	func scheduledAt() -> NSDate? {
		if (self.scheduledTime == nil) {
			return nil
		}
		
		return NSDate.init(timeIntervalSince1970: self.scheduledTime!.doubleValue)
	}
}
