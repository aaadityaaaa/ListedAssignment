//
//  LinkCell.swift
//  ListedAssignment
//
//  Created by Aaditya Singh on 02/07/23.
//

import SwiftUI
import UIKit

class LinkCell: UICollectionViewCell {
    
    static let reuseID = "LinkCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
   
    private lazy var brandLogoImageView: RemoteImageView = {
        let imageView = RemoteImageView()
        imageView.setAspectRatio(to: 1)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var linkNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Figtree-Regular", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightSecondaryColor()
        label.font = UIFont(name: "Figtree-Regular", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightSecondaryColor()
        label.font = UIFont(name: "Figtree-Regular", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var copyToClipBoardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clipboard"), for: .normal)
        return button
    }()
    
    private lazy var clicksAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightSecondaryColor()
        label.font = UIFont(name: "Figtree-SemiBold", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var clicksLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightSecondaryColor()
        label.text = "Clicks"
        label.font = UIFont(name: "Figtree-Regular", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var blueView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        return view
    }()
    
    func configure(image: String, linkName: String, link: String, date: String, clicksAmount: String) {
        linkNameLabel.text = linkName
        linkLabel.text = link
        dateLabel.text = date
        clicksAmountLabel.text = clicksAmount
        guard let url = URL(string: image) else {return}
        brandLogoImageView.setImage(with: url)
    }
    
    private func setupViews() {
        layer.cornerRadius = 8
        backgroundColor = .white
        
        addSubview(brandLogoImageView)
        addSubview(linkNameLabel)
        addSubview(dateLabel)
        addSubview(linkLabel)
        addSubview(clicksAmountLabel)
        addSubview(clicksLabel)
        addSubview(copyToClipBoardButton)
        insertSubview(blueView, at: 0)
        
        brandLogoImageView.pinLeading(withPadding: 12)
        brandLogoImageView.pinTop(withPadding: 12)
        brandLogoImageView.constrainHeight(equalTo: 48)
        
        linkNameLabel.pinLeadingToTrailing(of: brandLogoImageView, withSpacing: 12)
        linkNameLabel.constrainHeight(equalTo: 24)
        linkNameLabel.pinTop(withPadding: 12)
        linkNameLabel.pinTrailingToLeading(of: clicksAmountLabel, withSpacing: -92)
        
        dateLabel.pinLeadingToTrailing(of: brandLogoImageView, withSpacing: 12)
        dateLabel.constrainHeight(equalTo: 18)
        dateLabel.pinTopToBottom(of: linkNameLabel, withSpacing: 2)
        
        clicksAmountLabel.constrainHeight(equalTo: 24)
        clicksAmountLabel.pinTop(withPadding: 12)
        clicksAmountLabel.pinTrailing(withPadding: -12)
        
        clicksLabel.pinTopToBottom(of: clicksAmountLabel, withSpacing: 2)
        clicksLabel.constrainHeight(equalTo: 18)
        clicksLabel.pinTrailing(withPadding: -12)
        
        blueView.pinLeading(withPadding: 0)
        blueView.pinTrailing(withPadding: 0)
        blueView.pinBottom(withPadding: 0)
        blueView.pinTop(withPadding: 76)
        blueView.backgroundColor = .lightBlue()
        
        linkLabel.constrainHeight(equalTo: 11)
        linkLabel.pinLeading(withPadding: 12)
        linkLabel.pinTopToBottom(of: dateLabel, withSpacing: 32.5)
        //linkLabel.pinTrailingToLeading(of: copyToClipBoardButton, withSpacing: -67)
        
        copyToClipBoardButton.constrainHeight(equalTo: 24)
        copyToClipBoardButton.pinTopToBottom(of: clicksLabel, withSpacing: 26)
        copyToClipBoardButton.pinTrailing(withPadding: -12)
        
        
    }
}
