//
//  HomeView.swift
//  ProductV2
//
//  Created by Design on 18/8/26.
//



import UIKit

class HomeView: UIView, UICollectionViewDataSource {
    
    private var sliderItems: [SliderItem] = []
    private var dealItems: [DealItem] = []
    private let header = SectionHeader()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    private let contentView = UIView()
    
    // slider auto swap
    private var autoScrollTimer: Timer?
    private var currentIndex: Int = 0
    private let autoScrollInterval: TimeInterval = 2.0
    
    let sliderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.60, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        layout.minimumLineSpacing = 12
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(SliderCell.self, forCellWithReuseIdentifier: SliderCell.reuseID)
        return cv
    }()
    
    let dealsCollectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()

        // Vertical scrolling
        layout.scrollDirection = .vertical

        // 2 columns
        let spacing: CGFloat = 12
        let horizontalPadding: CGFloat = 16
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth
            - (horizontalPadding * 2)
            - spacing) / 2
        layout.itemSize = CGSize(
            width: itemWidth,
            height: 230
        )
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(
            top: 12,
            left: horizontalPadding,
            bottom: 12,
            right: horizontalPadding
        )

        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.register(
            DealCell.self,
            forCellWithReuseIdentifier: DealCell.reuseID
        )

        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sliderCollectionView.dataSource = self
        dealsCollectionView.dataSource = self
    
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // it auto call to stop run timer when we move to other screen
    deinit {
        stopAutoScroll()
    }
    func setSliderItems(_ items: [SliderItem]) {
        self.sliderItems = items
        sliderCollectionView.reloadData()
        
        if !items.isEmpty {
            currentIndex = 0
            startAutoScroll()
        }
    }
    func setDealItems(_ items: [DealItem]) {
        DispatchQueue.main.async {
            
            self.dealItems = items
            self.dealsCollectionView.reloadData()
            
            print("UI received deals: \(self.dealItems.count)")
        }
    }
    private func setupLayout() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(sliderCollectionView)
        contentView.addSubview(header)                                  
        contentView.addSubview(dealsCollectionView)
        sliderCollectionView.translatesAutoresizingMaskIntoConstraints = false
        header.translatesAutoresizingMaskIntoConstraints = false
        dealsCollectionView.translatesAutoresizingMaskIntoConstraints = false

        header.configure(title: "Today's best deals", actionTitle: "See All")
        
        // scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // contentView
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        // Slider
        NSLayoutConstraint.activate([
            sliderCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            sliderCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sliderCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sliderCollectionView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        // Header
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: sliderCollectionView.bottomAnchor, constant: 16),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            header.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Deals
        NSLayoutConstraint.activate([
            dealsCollectionView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 12),   // FIXED
            dealsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dealsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dealsCollectionView.heightAnchor.constraint(equalToConstant: 3 * 230 + 2 * 12 + 24),
            dealsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20)
        ])
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        if collectionView == sliderCollectionView {
            return sliderItems.count
        }
        
        if collectionView == dealsCollectionView {
            return dealItems.count
        }
        
        return 0
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        // MARK: - Slider
        
        if collectionView == sliderCollectionView {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SliderCell.reuseID,
                for: indexPath
            ) as! SliderCell
            
            cell.configure(
                with: sliderItems[indexPath.item]
            )
            
            return cell
        }
        
        // MARK: - Deals
        
        if collectionView == dealsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DealCell.reuseID,
                for: indexPath
            ) as! DealCell
            
            cell.configure(
                with: dealItems[indexPath.item]
            )
            
            return cell
        }
        
        return UICollectionViewCell()
    }
        
    // Start auto scroll
    private func startAutoScroll() {
        stopAutoScroll() // stop old timer first
        
        autoScrollTimer = Timer.scheduledTimer(
            timeInterval: autoScrollInterval,
            target: self,
            selector: #selector(scrollToNextItem),
            userInfo: nil,
            repeats: true
        )
    }

    // Stop auto scroll
    private func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }

    // Move to next slide
    @objc private func scrollToNextItem() {
        guard !sliderItems.isEmpty else { return }
        
        currentIndex += 1
        
        // If reach the end → go back to first item
        if currentIndex >= sliderItems.count {
            currentIndex = 0
        }
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        
        sliderCollectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
    }
   
}
