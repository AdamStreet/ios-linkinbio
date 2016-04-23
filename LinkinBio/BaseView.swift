//
//  BaseView.swift
//  LinkinBio
//
//  Created by Adam Szabo on 23/04/2016.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit

class BaseView: UIView {
	
	private var hasAlreadySetInitialContraints : Bool = false
	
	// MARK View lifecycle
	
	override func updateConstraints() {
		if (self.hasAlreadySetInitialContraints == false) {
			self.setupInitialConstraints()
			
			self.hasAlreadySetInitialContraints = true
		}
		
		super.updateConstraints()
	}
	
	// MARK: Public methods
	
	func setupInitialConstraints() {
		// does nothing by default
	}
}
