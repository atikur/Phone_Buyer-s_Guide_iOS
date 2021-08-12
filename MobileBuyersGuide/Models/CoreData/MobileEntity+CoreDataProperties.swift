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
            return NSFetchRequest<MobileEntity>(entityName: "AlbumEntity")
        }

    @NSManaged public var mobileId: String
    @NSManaged public var isFavorite: Bool

}
