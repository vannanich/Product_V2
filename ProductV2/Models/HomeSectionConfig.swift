//
//  HomeSectionConfig.swift
//  ProductV2
//
//  Created by Design on 18/8/26.
//
import Foundation

class HomeSectionConfig: NSObject, Codable {
    
    var display: String?
    var displayMode: String?
    var gap: String?
    var showArrows: Bool?
    var autoplay: Bool?
    var autoplayInterval: Int?
    var gridColumns: Int?
    var cardType: String?
    var styles: HomeSectionStyles?
    
    enum CodingKeys: String, CodingKey {
        case display
        case displayMode = "display_mode"
        case gap
        case showArrows = "show_arrows"
        case autoplay
        case autoplayInterval = "autoplay_interval"
        case gridColumns = "grid_columns"
        case cardType = "card_type"
        case styles
    }
}

class HomeSectionStyles: NSObject, Codable {
    
    var id: Int?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}
