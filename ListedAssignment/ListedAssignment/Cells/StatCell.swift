//
//  StatCell.swift
//  ListedAssignment
//
//  Created by Aaditya Singh on 02/07/23.
//

import SwiftUI
import UIKit

class StatCell: UIView {
    
    static let reuseID = "StatCell"
   
    private lazy var iconImageView: RemoteImageView = {
        let imageView = RemoteImageView()
        imageView.setAspectRatio(to: 1)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Figtree-SemiBold", size: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subHeadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightSecondaryColor()
        label.font = UIFont(name: "Figtree-Regular", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: String, heading: String, subHeading: String) {
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        iconImageView.image = UIImage(named: image)
        
    }
    
    private func setupViews() {
        layer.cornerRadius = 8
        backgroundColor = .white
        
        addSubview(iconImageView)
        addSubview(headingLabel)
        addSubview(subHeadingLabel)
        
        iconImageView.constrainWidth(equalTo: 32)
        iconImageView.pinTop(withPadding: 12)
        iconImageView.pinLeading(withPadding: 16)
        
        headingLabel.pinTopToBottom(of: iconImageView, withSpacing: 16)
        headingLabel.constrainHeight(equalTo: 24)
        headingLabel.pinLeading(withPadding: 12)
        
        subHeadingLabel.pinTopToBottom(of: headingLabel, withSpacing: 4)
        subHeadingLabel.constrainHeight(equalTo: 20)
        subHeadingLabel.pinLeading(withPadding: 12)
    }
}
