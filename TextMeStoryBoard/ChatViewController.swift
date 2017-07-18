//
//  ChatViewController.swift
//  TextMeStoryBoard
//
//  Created by Suvineet Singh on 18/07/2017.
//  Copyright © 2017 SuvineetSingh. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	
	@IBOutlet weak var tableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

			tableView.delegate = self
			
			tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 1
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		return MessageDetailCell()
	}

}
