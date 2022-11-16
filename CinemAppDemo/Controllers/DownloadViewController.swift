//
//  DownloadViewController.swift
//  CinemAppDemo
//
//  Created by Илья Жариков on 13.11.2022.
//

import UIKit

class DownloadViewController: UIViewController {
    
    private var titles: [TitleEntity] = [TitleEntity]()
    
    private let downloadsTableView = {
       let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identitifer)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(downloadsTableView)
        
        downloadsTableView.delegate = self
        downloadsTableView.dataSource = self
        getDownloads()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { [weak self] _ in
            self?.getDownloads()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadsTableView.frame = view.bounds
    }
    
    private func getDownloads() {
        DatabaseManager.instance.getTitles { [weak self] result in
            switch result {
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.downloadsTableView.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func deleteDownload(itemId: Int) {
        DatabaseManager.instance.deleteTitle(with: titles[itemId]) { result in
            switch result {
            case.failure(let error):
                print(error.localizedDescription)
            default:
                break;
            }
        }
    }
}

extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identitifer, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let titleName = title.original_name ?? title.original_title ?? ""
        guard let titlePosterPath = title.poster_path else { return UITableViewCell() }
        cell.configure(with: TitleViewModel(titleName: titleName, posterUrlPath: titlePosterPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case.delete:
            deleteDownload(itemId: indexPath.row)
            titles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break;
        }
    }
}
