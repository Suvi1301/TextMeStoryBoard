//
//  RegisterViewController.swift
//  TextMeStoryBoard
//
//  Created by Suvineet Singh on 17/07/2017.
//  Copyright © 2017 SuvineetSingh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var imgProfilePic: UIImageView!
	@IBOutlet	weak var txtUsername: UITextField!
	@IBOutlet weak var cmdComplete: UIButton!

	//Passed in from the Login View Controller
	var userId: String!
	
	var emailField: String!
	var pwordField: String!
	
	var imgPicker: UIImagePickerController!
	
	var imgSelected = false
	
	var username: String!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

			imgPicker = UIImagePickerController()
			imgPicker.delegate = self
			
			imgPicker.allowsEditing = true
    }

	override func viewDidDisappear(_ animated: Bool) {
		
		if let _ = KeychainWrapper.standard.string(forKey: "uid")	{
			
			self.performSegue(withIdentifier: "toMessages", sender: nil)
			
		}
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
		
		if let image = info[UIImagePickerControllerEditedImage]	{
			
			imgProfilePic.image = image as! UIImage
			
			imgSelected = true
			
		} else {
			
			print("Image not selected")
		}
		
		imgPicker.dismiss(animated: true, completion: nil)
		
	}
	
	func setUser(img: String) {
		
		let userData = [
		"username": username!,
		"userImg": img
		]
		
		KeychainWrapper.standard.set(userId, forKey: "uid")
		
		let location = FIRDatabase.database().reference().child("users").child(userId)
		
		location.setValue(userData)
	}
	
	func uploadImage() {
		
		if txtUsername.text == nil {
			
			cmdComplete.isEnabled = false
		
		} else {
			
			username = txtUsername.text
			
			cmdComplete.isEnabled = true
		}
		
		guard let img = imgProfilePic.image, imgSelected == true else {
			print("Must select an image")
			
			return
		}
		
		if let imgData = UIImageJPEGRepresentation(img, 0.2)	{
			
			let imgUid = NSUUID().uuidString
			
			let metadata = FIRStorageMetadata()
			
			metadata.contentType = "image/jpeg"
			
			FIRStorage.storage().reference().child(imgUid).put(imgData, metadata: metadata) { (metadata, error) in
				
				if error != nil {
					
					print("image not uploaded")
				} else {
					
					print("Uploaded!")
					
					let downloadURL = metadata?.downloadURL()?.absoluteString
					
					if let url = downloadURL {
					
						self.setUser(img: url)
					}
				}
			}
		}
		
		
		
	}
	
	@IBAction func createAccount (_ sender: AnyObject) {
		
		FIRAuth.auth()?.createUser(withEmail: emailField, password: pwordField, completion: { (user , error) in
			
			if error != nil {
				
				print("Error creating user")
				
			} else {
				
				if let user = user {
					self.userId = user.uid
				}
			}
			self.uploadImage()
		})
	}
	
	@IBAction func selectedImgPicker (_ sender: AnyObject)	{
		
		present(imgPicker, animated: true, completion: nil)
	}
	
	@IBAction func cancel (_ sender: AnyObject) {
		
		dismiss(animated: true, completion: nil)
	}
}

