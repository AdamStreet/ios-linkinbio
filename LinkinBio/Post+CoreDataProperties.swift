//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Adam Szabo on 23/04/2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Post {

    @NSManaged var postId: NSNumber?
    @NSManaged var caption: String?
    @NSManaged var creationTime: NSNumber?
    @NSManaged var imageURLString: String?
    @NSManaged var thumbnailURLString: String?
    @NSManaged var linkURLString: String?
    @NSManaged var videoURLString: String?
    @NSManaged var postTypeString: String?
    @NSManaged var scheduledTime: NSNumber?
    @NSManaged var profileId: NSNumber?
    @NSManaged var seen: NSNumber?

}
