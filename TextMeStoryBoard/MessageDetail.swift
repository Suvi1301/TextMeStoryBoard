//
//  MessageDetail.swift
//  TextMeStoryBoard
//
//  Created by Suvineet Singh on 18/07/2017.
//  Copyright © 2017 SuvineetSingh. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class MessageDetail {
	
	private var _recipient: String!
	
	private var _messageKey: String!
	
	private var _messageRef: FIRDatabaseReference!
	
	var currentUser = KeychainWrapper.standard.string(forKey: "uid")
	
	var recipient: String {
		
		return _recipient
	}
	
	var messageKey: String {
		
		return _messageKey
	}
	
	var messageRef: FIRDatabaseReference {
		
		return _messageRef
	}
	
	init(recipient: String) {
		
		_recipient = recipient
	}
	
	init(messageKey: String, messageData: Dictionary<String, AnyObject>) {
		
		_messageKey = messageKey
		
		if let recipient = messageData["recipient"] as? String {
			
			_recipient = recipient
		}
		
		_messageRef = FIRDatabase.database().reference().child("recipient").child(_messageKey)
		
		
	}
	
	
	
}
