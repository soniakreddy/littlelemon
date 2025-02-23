//
//  MenuItem.swift
//  Restaurant
//
//  Created by sokolli on 2/23/25.
//

import Foundation

struct MenuItem: Codable {
    let id: Int
    let title: String
    let image: String
    let price: String
    let description: String
    let category: String
}
