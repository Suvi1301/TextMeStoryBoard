//
//  MessagesCell.swift
//  TextMeStoryBoard
//
//  Created by Suvineet Singh on 20/07/2017.
//  Copyright © 2017 SuvineetSingh. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MessagesCell: UITableViewCell {

	@IBOutlet weak var lblRecievedMessage: UILabel!
	
	@IBOutlet weak var recievedMessageView: UIView!
	
	@IBOutlet weak var lblSentMessage: UILabel!
	
	@IBOutlet weak var sentMessageView: UIView!
	
	var message: Message!
	
	var currentUser = KeychainWrapper.standard.string(forKey: "uid")

	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func configCell(message: Message)	{
		
		self.message = message
		
		if message.sender == currentUser {
			
			sentMessageView.isHidden = false
			
			lblSentMessage.text = message.message
			
			lblRecievedMessage.text = ""
			
			lblRecievedMessage.isHidden = true
			
		} else {
			
			sentMessageView.isHidden = true
			
			lblSentMessage.text = ""
			
			lblRecievedMessage.text = message.message
			
			lblRecievedMessage.isHidden = false
		}
		
	}
	
}





















