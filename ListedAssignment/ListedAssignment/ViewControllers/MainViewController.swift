//
//  NewViewController.swift
//  ListedAssignment
//
//  Created by Aaditya Singh on 06/07/23.
//

import UIKit
import SwiftUI

final class MainViewController: DataLoadingVC {
    
    private var response: Response? = nil
    private let networkManager: ObjectService
    
    init(networkManager: ObjectService) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .collectionViewBackground()
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.alwaysBounceVertical = false
        return view
    }()
    
   private lazy var contentView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var goodMorningLabel: UILabel = {
        let label = UILabel()
        label.text = "Good Morning"
        label.font = UIFont(name: "Figtree-Regular", size: 16)
        label.textAlignment = .left
        label.textColor = .lightSecondaryColor()
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ajay Manva 👋"
        label.font = UIFont(name: "Figtree-SemiBold", size: 24)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var viewAnalyticsButton: CustomViewButton = {
        let button = CustomViewButton(title: "View Analytics", image: "Arrows")
        return button
    }()
    
    private lazy var viewAllLinksButton: CustomViewButton = {
        let button = CustomViewButton(title: "View all Links", image: "Mail")
        return button
    }()
    
    private lazy var talkWithUsButton: TintButton = {
        let button = TintButton(title: "Talk with us", image: "whatsapp", color: .talkWithUsColor().withAlphaComponent(0.10), strokeColor: .talkWithUsColor().withAlphaComponent(0.12))
        return button
    }()
    
    private lazy var faqButton: TintButton = {
        let button = TintButton(title: "Frequently Asked Questions", image: "info", color: .faqBackgroundColor(), strokeColor: .faqStrokeColor())
        return button
    }()
    
    private lazy var searchButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "search")
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.strokeColor().cgColor
        return view
    }()
    
    private lazy var topLinksButton: CapsuleButton = {
        let button = CapsuleButton()
        button.setTitle("Top Links", for: .normal)
        button.backgroundColor = button.isSelected ? .navBarBackgroundColor() : .clear
        button.setTitleColor( button.isSelected ? .white : .lightSecondaryColor(), for: .normal)
        button.isSelected = true
        button.addTarget(self, action: #selector(toplinksButtonTapped(_:)), for: .touchUpInside) // Add target action
        button.layer.cornerRadius = 18
        return button
    }()
    
    private lazy var recentLinksButton: CapsuleButton = {
        let button = CapsuleButton()
        button.setTitle("Recent Links", for: .normal)
        button.backgroundColor = button.isSelected ? .navBarBackgroundColor() : .clear
        button.setTitleColor( button.isSelected ? .white : .lightSecondaryColor(), for: .normal)
        button.isSelected = false
        button.addTarget(self, action: #selector(recentbuttonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private lazy var topLinksCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 328, height: 116)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.allowsMultipleSelection = true
        collectionView.register(LinkCell.self, forCellWithReuseIdentifier: LinkCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var recentLinksCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 328, height: 116)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.allowsMultipleSelection = true
        collectionView.register(LinkCell.self, forCellWithReuseIdentifier: LinkCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isHidden = true
        return collectionView
    }()
    
    private lazy var clickCell: StatCell =  {
        let view = StatCell()
        return view
    }()
    
    private lazy var locationCell: StatCell =  {
        let view = StatCell()
        return view
    }()
    
    private lazy var sourceCell: StatCell =  {
        let view = StatCell()
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .navBarBackgroundColor()
        configureNavigationBarAppearance()
        setNavigationBar()
        getData()
    }
    
    private func setupViews() {
        
        view.addSubview(scrollView)
        view.addSubview(bottomView)

        scrollView.pinTop(withPadding: 120)
        scrollView.pinLeading(withPadding: 0)
        scrollView.pinTrailing(withPadding: 0)
        scrollView.addSubview(contentView)
        
        contentView.pinTop(to: scrollView, withPadding: 0)
        contentView.pinBottom(to: scrollView, withPadding: 0)
        contentView.pinLeading(to: view, withPadding: 0)
        contentView.pinTrailing(to: view, withPadding: 0)
        
        contentView.addSubview(goodMorningLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(viewAnalyticsButton)
        contentView.addSubview(viewAllLinksButton)
        contentView.addSubview(faqButton)
        contentView.addSubview(talkWithUsButton)
        contentView.addSubview(clickCell)
        contentView.addSubview(locationCell)
        contentView.addSubview(sourceCell)
        contentView.addSubview(searchButton)
        contentView.addSubview(topLinksButton)
        contentView.addSubview(recentLinksButton)
        
        goodMorningLabel.constrainHeight(equalTo: 24)
        goodMorningLabel.pinLeading(withPadding: 16)
        goodMorningLabel.pinTop(withPadding: 32)
        goodMorningLabel.pinTrailing(withPadding: -239)
        
        nameLabel.constrainHeight(equalTo: 32)
        nameLabel.pinTopToBottom(of: goodMorningLabel, withSpacing: 4)
        nameLabel.pinLeading(withPadding: 16)
        nameLabel.pinTrailing(withPadding: -181)
        
        guard let response = response?.data.overallURLChart else { return }
        let swiftUIView = ChartView(data: response)
        let hostingController = UIHostingController(rootView: swiftUIView)
        guard let hostingView = hostingController.view else {return}
        
        addChild(hostingController)
        contentView.addSubview(hostingView)
        
        hostingView.constrainHeight(equalTo: 220)
        hostingView.pinLeading(withPadding: 16)
        hostingView.pinTrailing(withPadding: -16)
        hostingView.pinTopToBottom(of: nameLabel, withSpacing: 24)
        
        let horizontalScrollView = UIScrollView()
        horizontalScrollView.showsHorizontalScrollIndicator = false
        horizontalScrollView.isUserInteractionEnabled = true
        
        contentView.addSubview(horizontalScrollView)
        
        horizontalScrollView.pinLeading(withPadding: 0)
        horizontalScrollView.pinTrailing(withPadding: 0)
        horizontalScrollView.pinTopToBottom(of: hostingView, withSpacing: 20)
        horizontalScrollView.constrainHeight(equalTo: 160)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        horizontalScrollView.addSubview(stackView)
        
        stackView.pinLeading(withPadding: 20)
        stackView.pinTrailing(withPadding: 0)
        stackView.pinTop(withPadding: 0)
        stackView.pinBottom(withPadding: 0)
        
        stackView.addArrangedSubview(clickCell)
        clickCell.constrainHeight(equalTo: 120)
        clickCell.constrainWidth(equalTo: 120)
        
        stackView.addArrangedSubview(locationCell)
        locationCell.constrainHeight(equalTo: 120)
        locationCell.constrainWidth(equalTo: 120)
        
        stackView.addArrangedSubview(sourceCell)
        sourceCell.constrainHeight(equalTo: 120)
        sourceCell.constrainWidth(equalTo: 120)
        
        clickCell.configure(image: "click", heading: "\(self.response?.totalClicks ?? 0)", subHeading: "Today's Clicks")
        locationCell.configure(image: "location", heading: self.response?.topLocation ?? "", subHeading: "Top location")
        sourceCell.configure(image: "source", heading: self.response?.topSource ?? "", subHeading: "Top Source")

        viewAnalyticsButton.pinTopToBottom(of: horizontalScrollView, withSpacing: 0)
        viewAnalyticsButton.pinLeading(withPadding: 16)
        viewAnalyticsButton.pinTrailing(withPadding: -16)
        viewAnalyticsButton.constrainHeight(equalTo: 48)
        
        searchButton.constrainHeight(equalTo: 24)
        searchButton.constrainWidth(equalTo: 24)
        searchButton.pinTrailing(withPadding: -16)
        searchButton.pinTopToBottom(of: viewAnalyticsButton, withSpacing: 40)
        
        topLinksButton.constrainWidth(equalTo: 101)
        topLinksButton.constrainHeight(equalTo: 36)
        topLinksButton.pinLeading(withPadding: 16)
        topLinksButton.pinTopToBottom(of: viewAnalyticsButton, withSpacing: 40)

        recentLinksButton.constrainWidth(equalTo: 125)
        recentLinksButton.constrainHeight(equalTo: 36)
        recentLinksButton.pinLeadingToTrailing(of: topLinksButton, withSpacing: 12)
        recentLinksButton.pinTopToBottom(of: viewAnalyticsButton, withSpacing: 40)
        
        contentView.addSubview(topLinksCollectionView)
        topLinksCollectionView.pinLeading(to: view, withPadding: 0)
        topLinksCollectionView.pinTrailing(to: view, withPadding: 0)
        topLinksCollectionView.pinTopToBottom(of: searchButton, withSpacing: 28)
        topLinksCollectionView.constrainHeight(equalTo: 500)
        topLinksCollectionView.pinBottomToTop(of: viewAllLinksButton, withSpacing: -20)
        
        contentView.addSubview(recentLinksCollectionView)
        recentLinksCollectionView.pinLeading(to: view, withPadding: 0)
        recentLinksCollectionView.pinTrailing(to: view, withPadding: 0)
        recentLinksCollectionView.pinTopToBottom(of: searchButton, withSpacing: 28)
        recentLinksCollectionView.constrainHeight(equalTo: 500)
        recentLinksCollectionView.pinBottomToTop(of: viewAllLinksButton, withSpacing: -20)
        
        viewAllLinksButton.pinTopToBottom(of: topLinksCollectionView, withSpacing: 20)
        viewAllLinksButton.pinLeading(withPadding: 16)
        viewAllLinksButton.pinTrailing(withPadding: -16)
        viewAllLinksButton.constrainHeight(equalTo: 48)
        
        faqButton.pinLeading(withPadding: 16)
        faqButton.pinTrailing(withPadding: -16)
        faqButton.constrainHeight(equalTo: 48)
        faqButton.pinTopToBottom(of: viewAllLinksButton, withSpacing: 20)
        
        talkWithUsButton.pinLeading(withPadding: 16)
        talkWithUsButton.pinTrailing(withPadding: -16)
        talkWithUsButton.constrainHeight(equalTo: 48)
        talkWithUsButton.pinTopToBottom(of: faqButton, withSpacing: 20)
        talkWithUsButton.pinBottom(withPadding: -20)
        
        bottomView.pinLeading(withPadding: 0)
        bottomView.pinTrailing(withPadding: 0)
        bottomView.pinBottom(to: view, withPadding: 0)
        bottomView.constrainHeight(equalTo: 50)
        scrollView.pinBottomToTop(of: bottomView, withSpacing: 0)

    }
    
}

//MARK: - Functions
extension MainViewController {
    
    private func getData() {
        showLoadingView()
        networkManager.getData() { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.dismissLoadingView()
            switch result {
            case .success(let response):
                strongSelf.response = response
                DispatchQueue.main.async {
                    strongSelf.setupViews()
                }
            case .failure(let error):
                print("AD:: FAILURE ON FETCHING \(error)")
            }
        }
    }
    
    @objc private func recentbuttonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        topLinksButton.isSelected = false
        topLinksCollectionView.isHidden = true
        recentLinksCollectionView.isHidden = false
        recentLinksCollectionView.reloadData()
       }
    
    @objc private func toplinksButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        recentLinksButton.isSelected = false
        topLinksCollectionView.isHidden = false
        recentLinksCollectionView.isHidden = true
        topLinksCollectionView.reloadData()
       }
}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return response?.data.topLinks.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if recentLinksCollectionView.isHidden == true {
            let cell = topLinksCollectionView.dequeueReusableCell(withReuseIdentifier: LinkCell.reuseID, for: indexPath) as! LinkCell
            guard let object = response?.data.topLinks[indexPath.row] else { return UICollectionViewCell() }
                cell.configure(image: object.originalImage,
                               linkName: object.title,
                               link: object.smartLink,
                               date: object.createdAt,
                               clicksAmount: "\(object.totalClicks)")
            return cell
        } else {
            let cell = recentLinksCollectionView.dequeueReusableCell(withReuseIdentifier: LinkCell.reuseID, for: indexPath) as! LinkCell
            guard let object = response?.data.recentLinks[indexPath.row] else { return UICollectionViewCell() }
                cell.configure(image: object.originalImage,
                               linkName: object.title,
                               link: object.smartLink,
                               date: object.createdAt,
                               clicksAmount: "\(object.totalClicks)")
            return cell
        }
       
        
    }
}


extension MainViewController {
    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .navBarBackgroundColor()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    private func setNavigationBar() {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Dashboard"
        label.font = UIFont(name: "Figtree-SemiBold", size: 24)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: "settingsButton"), for: .normal)
        settingsButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: settingsButton)
    }
}
