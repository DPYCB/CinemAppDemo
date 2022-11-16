//
//  SearchResultsViewController.swift
//  CinemAppDemo
//
//  Created by Илья Жариков on 14.11.2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapItem(viewModel: TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {
    
    public var titles: [Title] = [Title]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.tag)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
}

extension SearchResultsViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.tag, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let posterPath = titles[indexPath.row].poster_path ?? ""
        cell.configure(with: posterPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let title = titles[indexPath.row]
        guard let titleName = title.original_name ?? title.original_title else {return}
        let titleOverview = title.overview ?? ""
        
        APICaller.instance.searchMovieTrailer(with: titleName) { [weak self] result in
            switch result {
            case.success(let video):
                let viewModel = TitlePreviewViewModel(title: titleName, youtubeVideo: video, titleOverview: titleOverview)
                self?.delegate?.didTapItem(viewModel: viewModel)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
