//
//  ViewController.swift
//  LinkinBio
//
//  Created by Ian MacKinnon on 2016-04-11.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

class ViewController : UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {

	@IBOutlet var collectionView : UICollectionView?
	
	var posts : [Post]?
	
	// MARK: Private methods
	
	private func updateData() {
		PostFetcher.sharedFetcher.fetchPosts { (posts : [Post]?) in
			print(posts)
			
			self.posts = posts
			
			self.collectionView?.reloadData()
		}
	}
	
	// MARK: View lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		self.updateData()
    }

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "OpenWebView") {
			let webViewController : WebViewController! = segue.destinationViewController as! WebViewController
			let tappedCell : ThumbCollectionViewCell! = sender as! ThumbCollectionViewCell
			
			webViewController.url = tappedCell.post?.linkURL
			webViewController.loadingCompletion = {
				tappedCell.post?.seen = true
			}
		}
	}
	// MARK: UICollectionViewDatasource
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		if (posts == nil) {
			return 0
		}
		
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return posts!.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ThumbCollectionViewCellIdentifier, forIndexPath: indexPath) as! ThumbCollectionViewCell
		
		cell.post = self.posts![indexPath.item]
		
		return cell
	}
	
	// MARK: UICollectionViewDelegate
	
//	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//		self.performSegueWithIdentifier("OpenWebView", sender: collectionView.cellForItemAtIndexPath(indexPath))
//	}
}

