//
//  MobileEntity+CoreDataProperties.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//
//

import Foundation
import CoreData


extension MobileEntity {
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<MobileEntity> {
            return NSFetchRequest<MobileEntity>(entityName: "MobileEntity")
        }

    @NSManaged public var mobileId: Int32
    @NSManaged public var isFavorite: Bool

}
