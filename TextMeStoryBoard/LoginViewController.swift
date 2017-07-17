//
//  ViewController.swift
//  TextMeStoryBoard
//
//  Created by Suvineet Singh on 17/07/2017.
//  Copyright © 2017 SuvineetSingh. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper


class LoginViewController: UIViewController {

	@IBOutlet weak var txtEmail: UITextField!
	
	@IBOutlet weak var txtPassword: UITextField!
	
	var userId: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func viewDidAppear(_ animated: Bool) {
		
		if let _ = KeychainWrapper.standard.string(forKey: "uid")	{
			
			self.performSegue(withIdentifier: "toMessages", sender: nil)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "toRegister" {
			
			if let destination = segue.destination as? RegisterViewController {
				
				if self.userId != nil {
					
					destination.userId = userId
				}
				
				if self.txtEmail.text != nil {
					
					destination.emailField = txtEmail.text
					
				}
				
				if self.txtPassword.text != nil {
					
					destination.pwordField = txtPassword.text
				}
			}
		}
	}
	
	@IBAction func Login (_ sender: AnyObject)	{
		
		if let email = txtEmail.text, let pword = txtPassword.text {
			
			FIRAuth.auth()?.signIn(withEmail: email, password: pword, completion:
				{ (user, error) in
				
				if error == nil {
					
					self.userId = user?.uid
					
					KeychainWrapper.standard.set(self.userId, forKey: "uid")
					
					self.performSegue(withIdentifier: "toMessages", sender: nil)
				
				} else {
					
					self.performSegue(withIdentifier: "toRegister", sender: nil)
				}
				
			})
		}
		
	}

}

