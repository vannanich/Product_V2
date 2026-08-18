//
//  HomeViewController.swift
//  ProductV2
//
//  Created by Design on 17/8/26.
//
// add header
// section


import UIKit

class HomeViewController: UIViewController {

    
    private let tabBarView = TabBarView()
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        view = homeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.sliderData()
//        setupTabBar()
    }
    private func setupTabBar() {
        view.addSubview(tabBarView)
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
        tabBarView.onSelect = { item in
            print("Tapped: \(item.title)")
        }
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
