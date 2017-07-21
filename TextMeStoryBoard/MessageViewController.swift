//
//  MessageViewController.swift
//  TextMeStoryBoard
//
//  Created by Suvineet Singh on 20/07/2017.
//  Copyright © 2017 SuvineetSingh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

	@IBOutlet weak var cmdSend: UIButton!
	@IBOutlet weak var txtMessage: UITextField!
	@IBOutlet weak var tableView: UITableView!
	
	var messageId: String!
	
	var recipient: String!
	
	var messages = [Message]()
	
	var message: Message!
	
	var currentUser = KeychainWrapper.standard.string(forKey: "uid")
	
	override func viewDidLoad() {
			super.viewDidLoad()
		
		tableView.delegate = self
		
		tableView.dataSource = self
		
		tableView.rowHeight = UITableViewAutomaticDimension
		
		tableView.estimatedRowHeight = 300
			// Do any additional setup after loading the view.
		
		if messageId != "" && messageId != nil {
			
			loadData()
		}
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		
		view.addGestureRecognizer(tap)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300))	{
			
			self.moveToBottom()
		}

	}
	
	func keyboardWillShow(notify: NSNotification)	{
		
		if let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
			
			if self.view.frame.origin.y == 0 {
				
				self.view.frame.origin.y -= keyboardSize.height
			}
		}
		
	}
	
	
	func keyboardWillHide(notify: NSNotification)	{
		
		if let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
			
			if self.view.frame.origin.y != 0 {
				
				self.view.frame.origin.y + keyboardSize.height
			}
		}
		
	}
	
	func dismissKeyboard() {
		
		view.endEditing(true)
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return messages.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let message = messages[indexPath.row]
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: "message") as? MessagesCell {
			
			cell.configCell(message: message)
			
			return cell
		
		} else {
			
			return MessagesCell()
		}
	}
	
	func loadData() {
		
		FIRDatabase.database().reference().child("messages").child(messageId).observe(.value, with: { (snapshot) in
			
			if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
				
				self.messages.removeAll()
				
				for data in snapshot {
					
					if let postDict = data.value as? Dictionary<String, AnyObject> {
						
						let key = data.key
						
						let post = Message(messageKey: key, postData: postDict)
						
						self.messages.append(post)
					}
				}
				
			}
			
			self.tableView.reloadData()
		})
	}
	
	
	func moveToBottom() {
		
		if messages.count > 0 {
			
			let indexPath = IndexPath(row: messages.count - 1, section: 0)
			
			tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
			
		}
	}
	
	@IBAction func sendPressed (_ sender: AnyObject) {
		
		dismissKeyboard()
		
		if (txtMessage.text != nil && txtMessage.text != "") {
			
			if messageId == nil {
				
				let post: Dictionary<String, AnyObject> = [
						"message": txtMessage.text as AnyObject,
						"sender": recipient as AnyObject
				]
				
				let message: Dictionary<String, AnyObject> = [
					"lastMessage": txtMessage.text as AnyObject,
					"recipient": recipient as AnyObject
				]
				
				let recipientMessage: Dictionary<String, AnyObject> = [
					"lastMessage": txtMessage.text as AnyObject,
					"recipient": currentUser as AnyObject
				]
				
				messageId = FIRDatabase.database().reference().child("messages").childByAutoId().key
				
				let firebaseMessage = FIRDatabase.database().reference().child("messages").child(messageId).childByAutoId()
				
				firebaseMessage.setValue(post)
				
				
				let recipentMessage = FIRDatabase.database().reference().child("users").child(recipient).child("messages").child(messageId)
				
				recipentMessage.setValue(recipientMessage)
				
				
				
				let userMessage = FIRDatabase.database().reference().child("users").child(currentUser!).childByAutoId()
				
				userMessage.setValue(post)
				
				
			} else {
				
				
			
			}
		}
		
	}
}
