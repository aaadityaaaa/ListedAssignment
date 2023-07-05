//
//  CapsuleButton.swift
//  ListedAssignment
//
//  Created by Aaditya Singh on 06/07/23.
//

import UIKit

class CapsuleButton: UIButton {
    
    override var isSelected: Bool {
            didSet {
                updateButtonAppearance()
            }
        }
    
    private func updateButtonAppearance() {
           if isSelected {
               backgroundColor = .navBarBackgroundColor()
               setTitleColor(.white, for: .selected)
           } else {
               backgroundColor = .clear
               setTitleColor(.lightSecondaryColor(), for: .normal)
           }
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        titleLabel?.font = UIFont(name: "Figtree-SemiBold", size: 16)
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        updateButtonAppearance()
    }
}
