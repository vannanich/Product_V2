//
//  HomeSectionModel.swift
//  ProductV2
//
//  Created by Design on 17/8/26.
//

import Foundation

class HomeResponse: NSObject, Codable {
    var success: Bool?
    var data: HomeData?

    enum CodingKeys: String, CodingKey {
        case success, data
    }
}

class HomeData: NSObject, Codable {
    var sections: [HomeSection]?
    enum CodingKeys: String, CodingKey {
        case sections
    }
}

class HomeSection: NSObject, Codable {
    var sectionId: Int?
    var sectionType: String?
    var title: String?
    var hydrate: String?
    var items :[DealItem]?
    var config: HomeSectionConfig?

    enum CodingKeys: String, CodingKey {
        case sectionId = "section_id"
        case sectionType = "section_type"
        case title
        case hydrate
        case items
    }
}
