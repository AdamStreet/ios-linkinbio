//
//  LoadingView.swift
//  LinkinBio
//
//  Created by Adam Szabo on 23/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

class LoadingView: BaseView {

	private(set) var activityIndicatorView : UIActivityIndicatorView!
	
	func sharedInit() {
		let activityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .Gray)
		activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false;
		activityIndicatorView.startAnimating()
		self.addSubview(activityIndicatorView)
		self.activityIndicatorView = activityIndicatorView
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.sharedInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.sharedInit()
	}
	
	// MARK: View lifecycle
	
	override func setupInitialConstraints() {
		super.setupInitialConstraints()
		
		let activityIndicatorView = self.activityIndicatorView
		
		self.addConstraint(NSLayoutConstraint.init(item: activityIndicatorView,
			attribute: .CenterX,
			relatedBy: .Equal,
			toItem: self,
			attribute: .CenterX,
			multiplier: 1.0,
			constant: 0.0))
		self.addConstraint(NSLayoutConstraint.init(item: activityIndicatorView,
			attribute: .CenterY,
			relatedBy: .Equal,
			toItem: self,
			attribute: .CenterY,
			multiplier: 1.0,
			constant: 0.0))
	}
	
}
