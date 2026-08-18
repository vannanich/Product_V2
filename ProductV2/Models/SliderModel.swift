
//
//  HomeRespone.swift
//  ProductV2
//
//  Created by Design on 17/8/26.
//

import Foundation

class SliderItem: NSObject, Codable {
    var id: Int?
    var image: String?
    var actionUrl: String?

    enum CodingKeys: String, CodingKey {
        case id, image
        case actionUrl = "action_url"
    }
}

class SliderHydrateResponse: NSObject, Codable {
    var success: Bool?
    var data: SliderHydrateData?
}

class SliderHydrateData: NSObject, Codable {
    var items: [SliderItem]?
}
