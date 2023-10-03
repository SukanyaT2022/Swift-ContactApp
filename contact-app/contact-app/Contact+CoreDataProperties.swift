//
//  Contact+CoreDataProperties.swift
//  contact-app
//
//  Created by Tiparpron Sukanya on 9/28/23.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?
    @NSManaged public var city: String?

}

extension Contact : Identifiable {

}
