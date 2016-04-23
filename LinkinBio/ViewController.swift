//
//  ViewController.swift
//  LinkinBio
//
//  Created by Ian MacKinnon on 2016-04-11.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit
import CoreData

class ViewController : BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

	@IBOutlet var collectionView : UICollectionView?
	@IBOutlet var collectionViewFlowLayout : UICollectionViewFlowLayout?
	
	lazy var postsFetchedResultsController : NSFetchedResultsController? = {
		let fetchedResultsController = PostFetcher.sharedFetcher.fetchedResultsController
		fetchedResultsController?.delegate = self
		
		return fetchedResultsController
	}()
	
	// MARK: Private methods
	
	private func updateData() {
		PostFetcher.sharedFetcher.updatePosts { (error : NSError?) in
			print(error)
			print(PostFetcher.sharedFetcher.posts())
		}
	}
	
	private func gapBetweenElements(collectionView : UICollectionView, collectionViewFlowLayout : UICollectionViewFlowLayout) -> CGFloat {
		let width : CGFloat = collectionView.bounds.width
		
		let numberOfItemsInRow = floor(width / collectionViewFlowLayout.itemSize.width)
		let totalGap = (width - (numberOfItemsInRow * collectionViewFlowLayout.itemSize.width))
		
		let gapBetweenElements = (totalGap / (numberOfItemsInRow + 1))
		
		return gapBetweenElements
	}
	
	private func configureCell(cell : ThumbCollectionViewCell, indexPath : NSIndexPath) {
		cell.post = self.postsFetchedResultsController?.fetchedObjects?[indexPath.item] as? Post
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
			let tappedPost = (sender as! ThumbCollectionViewCell).post
			
			webViewController.url = tappedPost?.postLinkURL()
			webViewController.loadingCompletion = {
				tappedPost?.seen = true
				
				print("marking post as seen: %@", tappedPost?.postId)
				
				DatabaseManager.sharedManager.saveContext()
			}
		}
	}
	
	// MARK: UICollectionViewDatasource
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		if let sections = self.postsFetchedResultsController?.sections {
			return sections.count
		}
		
		return 0
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if let sections = self.postsFetchedResultsController?.sections {
			let sectionInfo = sections[section]
			return sectionInfo.numberOfObjects
		}
		
		return 0
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ThumbCollectionViewCellIdentifier, forIndexPath: indexPath) as! ThumbCollectionViewCell
		
		self.configureCell(cell, indexPath: indexPath)
		
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
	
	//MARK: <NSFetchedResultsControllerDelegate>

	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		self.collectionView?.reloadData()	// Simplest solution, if we don't care about animations
	}
}

