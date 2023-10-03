//
//  CreateContactViewController.swift
//  contact-app
//
//  Created by Tiparpron Sukanya on 10/3/23.
//

import Foundation
import UIKit
class CreateContactViewController : UIViewController{
    
    @IBOutlet weak var contactImageView: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var contactImageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //action below line
    
    @IBAction func actionSaveButton(_ sender: Any) {
    }
    
    @IBAction func contactImageButtonAction(_ sender: Any) {
    }
}
