//
//  CustomViewButton.swift
//  ListedAssignment
//
//  Created by Aaditya Singh on 05/07/23.
//


import UIKit

class CustomViewButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, image: String) {
        self.init(frame: .zero)
        set(title: title, image: image)
    }
    
    final func set(title: String, image: String) {
        setImage(UIImage(named: image), for: .normal)
        setTitle(title, for: .normal)
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.strokeColor().cgColor
        layer.cornerRadius = 8
        backgroundColor = .clear
        setTitleColor(.black, for: .normal)
        titleLabel?.font =  UIFont(name: "Figtree-SemiBold", size: 16)
    }
    
}
