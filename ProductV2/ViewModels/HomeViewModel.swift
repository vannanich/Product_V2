//
//  HomeViewModel.swift
//  ProductV2
//
//  Created by Design on 18/8/26.
//


import Foundation

class HomeViewModel {
    
    private let homeService = HomeService.shared
    private(set) var sliderItems: [SliderItem] = []
    // best deal
    private(set) var dealItems: [DealItem] = []
    private(set) var dealsTitle: String = "Today's best deals"
    
    // Callbacks
    var onSliderUpdated: (() -> Void)?
    // best deal
    var onDealsUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchHomeData() {
        homeService.fetchSections { [weak self] sections in
            guard let self = self else { return }
            if let sliderSection = sections.first(where: { $0.sectionType == "shared.slider" }),
               let hydrateURL = sliderSection.hydrate {
                self.homeService.fetchSliderItems(hydrateURL: hydrateURL) { [weak self] items in
                    guard let self = self else { return }
                    self.sliderItems = items
                    self.onSliderUpdated?()
                }
            } else {
                self.onError?("Slider section not found")
            }
            
            if let dealsSection = sections.first(where: { $0.sectionType == "shared.deal-of-the-week-selections" }) {
                self.dealsTitle = dealsSection.config?.styles?.title ?? "Today's best deals"
                self.dealItems = dealsSection.items ?? []
                
                print("Deal title:", self.dealsTitle)
                print("Deal count:", self.dealItems.count)
                self.onDealsUpdated?()
            }
        }
    }
    
    var numberOfSliderItems: Int {
        return sliderItems.count
    }
    
    func sliderItem(at index: Int) -> SliderItem? {
        guard index >= 0 && index < sliderItems.count else { return nil }
        return sliderItems[index]
    }
    func dealItem(at index: Int) -> DealItem? {
            guard index >= 0 && index < dealItems.count else { return nil }
            return dealItems[index]
        }
}
