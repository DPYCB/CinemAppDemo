//
//  PromoHeaderUIView.swift
//  CinemAppDemo
//
//  Created by DPYCB on 13.11.2022.
//

import UIKit

class PromoHeaderUIView: UIView {

    private let promoImageView: UIImageView = WidgetsFactory.createImageView(enableConstraints: false)
    
    private let playButton = WidgetsFactory.createButton(label: "Play", enableConstraints: true)
    
    private let downloadButton = WidgetsFactory.createButton(label: "Download", enableConstraints: true)
    
    required init?(coder: NSCoder) {
        fatalError("Smth went wrong")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addGradient()
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        promoImageView.frame = bounds
    }
    
    public func configure(with viewModel: TitleViewState) {
        guard let url = APICaller.getPosterUrl(posterPath: viewModel.posterUrlPath) else { return }
        promoImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func addViews() {
        addSubview(promoImageView)
        addSubview(playButton)
        addSubview(downloadButton)
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func applyConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(playButtonConstraints + downloadButtonConstraints)
    }
}
