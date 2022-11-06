//
//  SupremeMonitorModel.swift
//  Enhance
//
//  Created by Michael Gillund on 9/17/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
// MARK: - Products, Categories, New
struct Products: Codable {
    let products: Categories

    enum CodingKeys: String, CodingKey {
        case products = "products_and_categories"
    }
}

struct Categories: Codable {
    let new: [New]
}

struct New: Codable {
    let id: Int
    let name: String
    let price: Int
    let category: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id
        case name, price
        case category = "category_name"
        case image = "image_url_hi"
    }
}
// MARK: - Stock, Style, Size
struct Stock: Codable {
    let styles: [Style]
}

struct Style: Codable {
    let name: String
    let id: Int
    let biggerZoomedURL: String
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case name, id
        case biggerZoomedURL = "bigger_zoomed_url"
        case sizes
    }
}
struct Size: Codable {
    let stockLevel: Int
    let name: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case stockLevel = "stock_level"
        case name, id
    }
}
// MARK: - Images, HDImages
struct Images: Codable {
    let styles: [HDImages]
}

struct HDImages: Codable {
    let biggerZoomedURL: String

    enum CodingKeys: String, CodingKey {
        case biggerZoomedURL = "bigger_zoomed_url"
    }
}
// MARK: -

