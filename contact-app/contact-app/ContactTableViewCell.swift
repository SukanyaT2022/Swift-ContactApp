//
//  ContactTableViewCell.swift
//  contact-app
//
//  Created by Tiparpron Sukanya on 9/28/23.
//

import Foundation
import UIKit
class  ContactTableViewCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    var contactData: Contact?//this contact from entity class name
    
}
