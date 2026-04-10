//
//  Quote.swift
//  MyAdetApp
//
//  Created by Дастан Жалгас on 09.12.2025.
//

import Foundation

struct QuoteElement: Codable {
    let q, a, h: String
}

typealias Quote = [QuoteElement]

