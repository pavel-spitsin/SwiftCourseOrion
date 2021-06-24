//
//  User+CoreDataProperties.swift
//  MyCoreDataLesson
//
//  Created by Pavel Spitcyn on 23.06.2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var isMain: Bool
    @NSManaged public var anyBool: NSNumber?
    @NSManaged public var company: Company?

}

extension User : Identifiable {

}
