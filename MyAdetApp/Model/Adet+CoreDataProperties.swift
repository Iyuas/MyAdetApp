//
//  Adet+CoreDataProperties.swift
//  MyAdetApp
//
//  Created by Serdaly Muhammed on 16.12.2025.
//
//

import Foundation
import CoreData


extension Adet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Adet> {
        return NSFetchRequest<Adet>(entityName: "Adet")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var date: Date?
    @NSManaged public var goalDays: Int32
    @NSManaged public var name: String?
    @NSManaged public var streak: Int64

}

extension Adet : Identifiable {

}
