//
//  HomeModel.swift
//  ProductV2
//
//  Created by Design on 18/8/26.
//
import Foundation

 class Badge: Codable {
    var type: String?
    var text: String?
    var color: String?
    var textColor: String?
}

 class DealItem:NSObject,Codable {
     var id: Int?
     var title: String?
     var image: String?
     var actionURL: String?
     var badge: Badge?
     var descriptionText: String?
     
     func encode(to encoder: any Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encodeIfPresent(self.id, forKey: .id)
         try container.encodeIfPresent(self.title, forKey: .title)
         try container.encodeIfPresent(self.image, forKey: .image)
         try container.encodeIfPresent(self.actionURL, forKey: .actionURL)
         try container.encodeIfPresent(self.badge, forKey: .badge)
         try container.encode(self.descriptionText, forKey: .descriptionText)
     }
     enum CodingKeys: String, CodingKey {
         case id
         case title
         case image
         case actionURL = "action_url"
         case badge
         case descriptionText = "description"
     }
     
     required init(from decoder: any Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         self.id = try container.decodeIfPresent(Int.self, forKey: .id)
         self.title = try container.decodeIfPresent(String.self, forKey: .title)
         self.image = try container.decodeIfPresent(String.self, forKey: .image)
         self.actionURL = try container.decodeIfPresent(String.self, forKey: .actionURL)
         self.badge = try container.decodeIfPresent(Badge.self, forKey: .badge)
         self.descriptionText = try container.decodeIfPresent(String.self,forKey: .descriptionText)
         super.init()
     }
    
}
