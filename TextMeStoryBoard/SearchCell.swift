
//
//  SearchCell.swift
//  TextMeStoryBoard
//
//  Created by Suvineet Singh on 21/07/2017.
//  Copyright © 2017 SuvineetSingh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class SearchCell: UITableViewCell {

	@IBOutlet weak var image: UIImageView!
	
	@IBOutlet weak var lblName: UILabel!
	
	var searchDetail: Search!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configCell(searchDetail: Search) {
		
		self.searchDetail = searchDetail
		
		lblName.text = searchDetail.username
		
		let ref = FIRStorage.storage().reference(forURL: searchDetail.userImg)
		
		ref.data(withMaxSize: 1000000, completion: { (data, error) in
			
			if error != nil {
				
				print("Could not upload image")
				
			} else {
				
				if let imgData = data {
					
					if let img = UIImage(data: imgData)	{
						
						self.image.image = img
					}
				}
				
			}
		
		})
		
	}

}
