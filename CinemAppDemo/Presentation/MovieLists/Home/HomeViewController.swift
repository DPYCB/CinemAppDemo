//

import Foundation
import UIKit

class HomeViewController : UIViewController {
    
    private let homeFeedTable = WidgetsFactory.createTableView(cellClass: CollectionViewTableViewCell.self, tag: CollectionViewTableViewCell.tag)
    
    private let viewModel: HomeViewModel
        
    private var promoHeaderView: PromoHeaderUIView?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, _ homeViewModel: HomeViewModel) {
        self.viewModel = homeViewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        promoHeaderView = PromoHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        homeFeedTable.tableHeaderView = promoHeaderView
        configureHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "SomeLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func configureHeaderView() {
        let title = viewModel.getRandomTrendingTitle()
        let titleName = title?.original_name ?? title?.original_name ?? ""
        guard let titlePosterPath = title?.poster_path else {return}
        self.promoHeaderView?.configure(with: TitleViewState(titleName: titleName, posterUrlPath: titlePosterPath))
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.tag, for: indexPath) as? CollectionViewTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        var titles = [Title]()
        switch indexPath.section {
        case Sections.TrendingMovies.id:
            titles = viewModel.getTrendingMovies()
        case Sections.TrendingTV.id:
            titles = viewModel.getTrendingTvShows()
        case Sections.Popular.id:
            titles = viewModel.getPopularMovies()
        case Sections.UpcomingMovies.id:
            titles = viewModel.getUpcomingMovies()
        case Sections.TopRated.id:
            titles = viewModel.getTopRatedMovies()
        default:
            print("No titles available for section " + String(indexPath.section))
        }
        cell.configure(with: titles)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WidgetsFactory.TABLE_VIEW_ITEM_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return WidgetsFactory.TABLE_VIEW_ITEM_WIDTH
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getSectionTitle(section)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.lowercased().capitalized
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = defaultOffset + scrollView.contentOffset.y
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func didTapCell(cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let titlePreviewViewController = TitlePreviewViewController()
            titlePreviewViewController.configure(with: viewModel)
            self?.navigationController?.pushViewController(titlePreviewViewController, animated: true )
        }
    }
}
