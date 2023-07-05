//
//  ChartCell.swift
//  ListedAssignment
//
//  Created by Aaditya Singh on 05/07/23.
//

import SwiftUI
import UIKit

class ChartCell: UICollectionViewCell {
    
    static let reuseID = "ChartCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var sample: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    func configure(data: [String: Int]) {
        let vc = UIHostingController(rootView: ChartView(data: data))
        sample = vc.view!
    }
    
    func setupViews() {
        addSubview(sample)
        sample.constrainHeight(equalTo: 200)
        sample.pinLeading(withPadding: 16)
        sample.pinTrailing(withPadding: -16)
        sample.pinTop(withPadding: 0)
    }
}
