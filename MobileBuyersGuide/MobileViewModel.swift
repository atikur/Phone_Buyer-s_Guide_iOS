//
//  MobileViewModel.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import UIKit

struct MobileViewModel {
    
    let id: Int
    let rating: Double
    let thumbImageURL: String
    let brand: String
    let price: Double
    let name: String
    let description: String
    
    init(with mobile: Mobile) {
        self.id = mobile.id
        self.rating = mobile.rating
        self.thumbImageURL = mobile.thumbImageURL
        self.brand = mobile.brand
        self.price = mobile.price
        self.name = mobile.name
        self.description = mobile.description
    }
    
    func isFavorite() -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let request = MobileEntity.createFetchRequest()
        request.predicate = NSPredicate(format: "mobileId == %@", String(self.id))
        
        do {
            let results = try appDelegate.persistentContainer.viewContext.fetch(request)
            return results.count > 0
        } catch {
            print(error)
        }
        
        return false
    }
    
    func addToFavorite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let mobileEntity = MobileEntity(context: appDelegate.persistentContainer.viewContext)
        mobileEntity.mobileId = Int32(id)
        mobileEntity.isFavorite = true
        appDelegate.saveContext()
    }
    
    func removeFromFavorite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let request = MobileEntity.createFetchRequest()
        request.predicate = NSPredicate(format: "mobileId == %@", String(self.id))
        
        do {
            let results = try appDelegate.persistentContainer.viewContext.fetch(request)
            guard let result = results.first else {
                return
            }
            appDelegate.persistentContainer.viewContext.delete(result)
            appDelegate.saveContext()
        } catch {
            print(error)
        }
    }
}
