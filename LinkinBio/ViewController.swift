//
//  ViewController.swift
//  LinkinBio
//
//  Created by Ian MacKinnon on 2016-04-11.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

class ViewController : BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource {

	@IBOutlet var collectionView : UICollectionView?
	@IBOutlet var collectionViewFlowLayout : UICollectionViewFlowLayout?
	
	var posts : [Post]?
	
	// MARK: Private methods
	
	private func updateData() {
		PostFetcher.sharedFetcher.fetchPosts { (posts : [Post]?) in
			print(posts)
			
			self.posts = posts
			
			self.collectionView?.reloadData()
		}
	}
	
	private func gapBetweenElements(collectionView : UICollectionView, collectionViewFlowLayout : UICollectionViewFlowLayout) -> CGFloat {
		let width : CGFloat = collectionView.bounds.width
		
		let numberOfItemsInRow = floor(width / collectionViewFlowLayout.itemSize.width)
		let totalGap = (width - (numberOfItemsInRow * collectionViewFlowLayout.itemSize.width))
		
		let gapBetweenElements = (totalGap / (numberOfItemsInRow + 1))
		
		return gapBetweenElements
	}
	
	// MARK: View lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		self.updateData()	// I would do this in `viewWillAppear(Bool)`
    }
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		self.collectionViewFlowLayout?.invalidateLayout()
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
	
	// MARK: UICollectionViewDelegateFlowLayout
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		let collectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
		
		let gapBetweenElements = self.gapBetweenElements(collectionView, collectionViewFlowLayout: collectionViewFlowLayout)
		
		return UIEdgeInsetsMake(gapBetweenElements, gapBetweenElements, gapBetweenElements, gapBetweenElements)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		let collectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
		
		return self.gapBetweenElements(collectionView, collectionViewFlowLayout: collectionViewFlowLayout)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		let collectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
		
		return self.gapBetweenElements(collectionView, collectionViewFlowLayout: collectionViewFlowLayout)
	}
}

