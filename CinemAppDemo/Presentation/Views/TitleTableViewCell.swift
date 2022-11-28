//

import UIKit

class TitleTableViewCell: UITableViewCell {
    static let tag = "TitleTableViewCell"
    
    private let posterImageView = WidgetsFactory.createImageView(enableConstraints: true)

    private let playButton = WidgetsFactory.createIconButton(systemName: "play.circle", enableConstraints: true)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        applyConstraints()
    }
    
    private func addViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
    }
    
    private func applyConstraints() {
        let posterImageViewConstraints = [
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(posterImageViewConstraints + titleLabelConstraints + playButtonConstraints)
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = APICaller.getPosterUrl(posterPath: model.posterUrlPath) else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
}
