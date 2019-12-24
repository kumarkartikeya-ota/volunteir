//
//  SignUpAdminViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/23/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class SignUpAdminViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    lazy var username = "\(firstName.text!) \(lastName.text!)"
    lazy var passWord = password.text
    lazy var eMail = email.text
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didRegister(_ sender: Any) {
        Auth.auth().createUser(withEmail: eMail!, password: passWord!) {
            (user, error) in
            if(error != nil){
                print(error!)
            }
            else{
                print("Registration succesful!")
                self.pushUserInfo()
                self.performSegue(withIdentifier: "registrationSuccess", sender: self)
            }
        }
    }
    func pushUserInfo(){
          let ref = Database.database().reference()
//        let users = ref.child("users")
//        let first = users.child(username).child("first name")
//        first.setValue(firstName.text)
//        let last = users.child(username).child("last name")
//        last.setValue(lastName.text)
//        let hours = users.child(username).child("hours")
//        hours.setValue(0)
//        let isUser = users.child(username).child("type")
//        isUser.setValue("user")
        
        let infoDict = ["First name": firstName.text!, "Last name": lastName.text!, "type" : "admin"] as [String : Any]
        let users = ref.child("users").child(username)
        users.setValue(infoDict)
    }

}
