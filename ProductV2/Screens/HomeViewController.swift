//
//  HomeViewController.swift
//  ProductV2
//
//  Created by Design on 17/8/26.
//


import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.fetchHomeData()
    }
    
    private func bindViewModel() {
        
        viewModel.onSliderUpdated = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.homeView.setSliderItems(self.viewModel.sliderItems)
                print("Slider items loaded: \(self.viewModel.sliderItems.count)")
            }
        }
        viewModel.onDealsUpdated = { [weak self] in
            
            guard let self = self else { return }
            
            self.homeView.setDealItems(
                self.viewModel.dealItems
            )
        }
        
        viewModel.onError = { errorMessage in
            print("Error:", errorMessage)
        }
        
    }
    
}
