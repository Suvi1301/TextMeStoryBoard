//
//  Message.swift
//  TextMeStoryBoard
//
//  Created by Suvineet Singh on 20/07/2017.
//  Copyright © 2017 SuvineetSingh. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class Message {
	
	private var _message: String!
	
	private var _sender: String!
	
	private var _messageKey: String!
	
	private var _messageRef: FIRDatabaseReference!
	
	var currentUser = KeychainWrapper.standard.string(forKey: "uid")
	
	var message: String {
		
		return _message
	}
	
	var sender: String {
		
		return _sender
	}
	
	var messageKey: String {
		
		return _messageKey
	}
	
	var messageRef: FIRDatabaseReference {
		
		return _messageRef
	}
	
	
	init(message: String, sender: String) {
		
		_message = message
		
		_sender = sender
	}
	
	init(messageKey: String, postData: Dictionary<String, AnyObject>)	{
		
		_messageKey = messageKey
		
		if let message = postData["message"] as? String {
			
			_message = message
		
		}
		
		if let sender = postData["sender"] as? String {
			
			_sender = sender
			
		}
		
		_messageRef = FIRDatabase.database().reference().child("messages").child(_messageKey)
	}
}
