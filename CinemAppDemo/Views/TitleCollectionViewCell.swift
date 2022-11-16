//
//  TitleCollectionViewCell.swift
//  CinemAppDemo
//
//  Created by Илья Жариков on 14.11.2022.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    static let tag = "TitleCollectionViewCell"
    
    private let posterView = WidgetsFactory.createImageView(enableConstraints: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        guard let posterUrl = APICaller.getPosterUrl(posterPath: model) else { return }
        posterView.sd_setImage(with: posterUrl, completed: nil)
    }
}
