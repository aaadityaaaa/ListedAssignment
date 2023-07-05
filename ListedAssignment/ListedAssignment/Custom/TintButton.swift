//
//  TintButton.swift
//  ListedAssignment
//
//  Created by Aaditya Singh on 05/07/23.
//

import UIKit

class TintButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, image: String, color: UIColor, strokeColor: UIColor) {
        self.init(frame: .zero)
        set(title: title, image: image, color: color, strokeColor: strokeColor)
    }
    
    final func set(title: String, image: String, color: UIColor, strokeColor: UIColor) {
        setImage(UIImage(named: image), for: .normal)
        setTitle(title, for: .normal)
        layer.borderWidth = 1.5
        layer.borderColor = strokeColor.withAlphaComponent(0.32).cgColor
        layer.cornerRadius = 8
        backgroundColor = color
        setTitleColor(.black, for: .normal)
        titleLabel?.font =  UIFont(name: "Figtree-SemiBold", size: 16)
        contentHorizontalAlignment = .left
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
}
