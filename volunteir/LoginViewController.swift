//
//  LoginViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/23/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var invalidError: UILabel!
    
    lazy var username = "\(firstName.text!)\(lastName.text!)"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        invalidError.isHidden = true
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        var success = true
        var type = "test"
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) {
                (user, error) in
                if(error != nil){
                    print(error!)
                    success = false
                    self.invalidError.isHidden = false
                }
                else{
                    print("success")
                    let ref = Database.database().reference().child("users/\(self.username)")
                     ref.observeSingleEvent(of: .value, with: { (snapshot) in
                     // Now you can access the type value
                     let value = snapshot.value as? NSDictionary
                        print(value)
                     type = (value!["type"])! as! String
                    if(type == "user"){
                        self.performSegue(withIdentifier: "goToUser", sender: self)
                        }
                        else{
                        self.performSegue(withIdentifier: "goToAdmin", sender: self)
                        }
                      }) { (error) in
                        print(error.localizedDescription)
                    }
                }
        }
    
    }
}
