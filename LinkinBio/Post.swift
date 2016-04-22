//
//  Post.swift
//  LinkinBio
//
//  Created by Adam Szabo on 22/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import Foundation

let PostKeyPostIdKey : String = "id"
let PostKeyCreatedTimeKey : String = "created_time"
let PostKeyImageURLStringKey : String = "image_url"
let PostKeyThumbURLStringKey : String = "thumb_url"
let PostKeyLinkURLStringKey : String = "link_url"
let PostKeyVideoURLKey : String = "video_url"
let PostKeyPostTypeKey : String = "gram_type"
let PostKeyCaption : String = "caption"
let PostKeyScheduledTimeKey : String = "scheduled_time"
let PostKeyProfileIdKey : String = "profile_id"

class Post : NSObject {
	private(set) var postId : NSNumber!
	private(set) var creationDate : NSDate!
	private(set) var imageURL : NSURL!
	private(set) var thumbURL : NSURL!
	private(set) var linkURL : NSURL!
	private(set) var profileId : NSNumber!
	private(set) var scheduledDate : NSDate!
	private(set) var videoURL : NSURL?
	private(set) var type : NSString?
	private(set) var caption : NSString?
	
 	dynamic var seen = false
	
	/*
	Example:
	{
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
	},*/
	
	convenience init(metadata : [String : AnyObject]) {
		let createdTime : NSNumber = metadata[PostKeyCreatedTimeKey] as! NSNumber
		let imageURLString : String = metadata[PostKeyImageURLStringKey] as! String
		let thumbURLString : String = metadata[PostKeyThumbURLStringKey] as! String
		let linkURLString : String = metadata[PostKeyLinkURLStringKey] as! String
		let scheduledTime : NSNumber = metadata[PostKeyScheduledTimeKey] as! NSNumber
		
		let videoURLString : String? = metadata[PostKeyVideoURLKey] as? String
		let type : String? = metadata[PostKeyPostTypeKey] as? String
		let caption : String? = metadata[PostKeyCaption] as? String
		
		var videoURL : NSURL?
		if (videoURLString != nil) {
			videoURL = NSURL.init(string: (videoURLString as String!))
		}
		
		self.init(id: metadata[PostKeyPostIdKey] as! NSNumber,
		          creationDate: NSDate.init(timeIntervalSince1970: createdTime.doubleValue),
		          imageURL: NSURL.init(string: imageURLString),
		          thumbURL: NSURL.init(string: thumbURLString),
		          linkURL: NSURL.init(string: linkURLString),
		          profileId: metadata[PostKeyProfileIdKey] as! NSNumber,
		          scheduledDate: NSDate.init(timeIntervalSince1970: scheduledTime.doubleValue),
		          videoURL: videoURL,
		          type: type,
		          caption: caption)
	}
	
	convenience init(id : NSNumber!,
	                creationDate : NSDate!,
	                imageURL : NSURL!,
	                thumbURL : NSURL!,
	                linkURL : NSURL!,
	                profileId : NSNumber!,
	                scheduledDate : NSDate!,
	                videoURL : NSURL?,
	                type : NSString?,
	                caption : NSString?) {
		self.init();
		
		self.postId = id
		self.creationDate = creationDate
		self.imageURL = imageURL
		self.thumbURL = thumbURL
		self.linkURL = linkURL
		self.profileId = profileId
		self.scheduledDate = scheduledDate
		self.videoURL = videoURL
		self.type = type
		self.caption = caption
	}
}
