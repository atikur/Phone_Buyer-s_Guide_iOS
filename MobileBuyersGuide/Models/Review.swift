//
//  Review.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 12/8/21.
//

import Foundation

struct Review: Codable {
    let id: Int
    let rating: Double
    let thumbImageURL: String
    let brand: String
    let price: Double
    let name: String
    let description: String
}
