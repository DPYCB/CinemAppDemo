//

import UIKit

class DownloadViewController: UIViewController {
    
    private let downloadsTableView = WidgetsFactory.createTableView(cellClass: TitleTableViewCell.self, tag: TitleTableViewCell.tag)
    
    private let viewModel: DownloadsViewModel
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, _ downloadsViewModel: DownloadsViewModel) {
        self.viewModel = downloadsViewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(downloadsTableView)
        
        downloadsTableView.delegate = self
        downloadsTableView.dataSource = self
        updateTableView()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { [weak self] _ in
            self?.updateTableView()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadsTableView.frame = view.bounds
    }
    
    private func updateTableView() {
        viewModel.updateDownloads()
        DispatchQueue.main.async { self.downloadsTableView.reloadData() }
    }
}

extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDownloadsCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.tag, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        guard let titleViewState = viewModel.getTitleViewState(itemId: indexPath.row) else { return UITableViewCell() }
        cell.configure(with: titleViewState)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case.delete:
            viewModel.deleteDownload(itemId: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break;
        }
    }
}
