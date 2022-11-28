//
//  TitlePreviewViewController.swift
//  CinemAppDemo
//
//  Created by DPYCB on 15.11.2022.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
        
    private let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let overviewLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let downdloadButton = WidgetsFactory.createButton(label: "Download", enableConstraints: true)
    
    private let webView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addViews()
        applyConstraints()
    }
    
    private func addViews() {
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downdloadButton)
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        guard let url = URL(string: model.getYoutubeVideoUrlString()) else {return}
        webView.load(URLRequest(url: url))
    }
    
    private func applyConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadButtonConstraints = [
            downdloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downdloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downdloadButton.widthAnchor.constraint(equalToConstant: 140),
            downdloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints + titleLabelConstraints + overviewLabelConstraints + downloadButtonConstraints)
    }
}
