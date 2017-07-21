//
//  SearchViewController.swift
//  TextMeStoryBoard
//
//  Created by Suvineet Singh on 21/07/2017.
//  Copyright © 2017 SuvineetSingh. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SearchViewController: UIViewController {

	@IBOutlet weak var searchBar: UISearchBar!
	
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	@IBAction func back(_ sender: AnyObject)	{
		
		dismiss(animated: true, completion: nil)
		
	}

}
