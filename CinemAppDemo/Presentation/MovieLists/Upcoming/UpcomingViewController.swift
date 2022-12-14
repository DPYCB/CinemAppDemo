//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
        
    private let upcomingTable = WidgetsFactory.createTableView(cellClass: TitleTableViewCell.self, tag: TitleTableViewCell.tag)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcomingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcomingMovies() {
        APICaller.instance.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.tag, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let titleName = title.original_name ?? title.original_title ?? ""
        guard let posterPath = title.poster_path else { return UITableViewCell() }
        cell.configure(with: TitleViewState(titleName: titleName, posterUrlPath: posterPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let title = titles[indexPath.row]
        guard let titleName = title.original_name ?? title.original_title else {return}
        
        APICaller.instance.searchMovieTrailer(with: titleName) { [weak self] result in
            switch result {
            case .success(let video):
                DispatchQueue.main.async {
                    let viewController = TitlePreviewViewController()
                    viewController.configure(with: TitlePreviewViewModel(title: titleName, youtubeVideo: video, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
