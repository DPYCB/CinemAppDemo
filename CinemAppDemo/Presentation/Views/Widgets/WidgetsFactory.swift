//
//  Widgets.swift
//  CinemAppDemo
//
//  Created by DPYCB on 16.11.2022.
//

import Foundation
import UIKit

class WidgetsFactory {
    static func createButton(label: String, enableConstraints: Bool) -> UIButton {
        let button = UIButton()
        button.setTitle(label, for: .normal)
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = !enableConstraints
        return button
    }
    
    static func createIconButton(systemName: String, enableConstraints: Bool) -> UIButton {
        let button = UIButton()
        let image = UIImage(systemName: systemName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 50))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = !enableConstraints
        button.tintColor = .white
        return button
    }
    
    static func createImageView(enableConstraints: Bool) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = !enableConstraints
        return imageView
    }
    
    static func createTableView(cellClass: AnyClass?, tag: String) -> UITableView {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(cellClass, forCellReuseIdentifier: tag)
        return table
    }
}
