//
//  MobileViewModel.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import Foundation

struct MobileViewModel: Codable {
    let id: Int
    let rating: Double
    let thumbImageURL: String
    let brand: String
    let price: Double
    let name: String
    let description: String
    var isFavorite: Bool
    
    init(with mobile: Mobile) {
        self.id = mobile.id
        self.rating = mobile.rating
        self.thumbImageURL = mobile.thumbImageURL
        self.brand = mobile.brand
        self.price = mobile.price
        self.name = mobile.name
        self.description = mobile.description
        self.isFavorite = false
    }
}
