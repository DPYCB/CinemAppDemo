//

import Foundation
import Swinject

final class AppDIContainer {
    static let instance = create()
    static func create() -> Container {
        let container = Container()
        container.register(DatabaseManager.self) { _ in DatabaseManager.instance}
        container.register(APICaller.self) { _ in APICaller.instance}
        
        container.register(TitlesRepository.self) { r in
            TitlesRepositoryImpl(titlesDatabase: r.resolve(DatabaseManager.self)!, titlesApi: r.resolve(APICaller.self)!)
        }
        
        container.register(HomeViewController.self) { _ in
            HomeViewController()
        }
        container.register(UpcomingViewController.self) { _ in
            UpcomingViewController()
        }
        container.register(SearchViewController.self) { _ in
            SearchViewController()
        }
        
        container.register(DownloadTitlesUseCases.self) { r in
            DownloadTitlesUseCasesImpl(titlesRepository: r.resolve(TitlesRepository.self)!)
        }
        container.register(DownloadsViewModel.self) { r in
            DownloadsViewModelImpl(downloadTitlesUseCases: r.resolve(DownloadTitlesUseCases.self)!)
        }
        container.register(DownloadViewController.self) { r in
            let controller = DownloadViewController(nibName: nil, bundle: nil, r.resolve(DownloadsViewModel.self)!)
            return controller
        }
        
        container.register(MainTabBarViewController.self) { r in
            let homeViewController = r.resolve(HomeViewController.self)!
            let upcomingViewController = r.resolve(UpcomingViewController.self)!
            let searchViewController = r.resolve(SearchViewController.self)!
            let downloadViewController = r.resolve(DownloadViewController.self)!
            
            let controller = MainTabBarViewController(nibName: "MainTabViewController", bundle: nil, homeViewController, upcomingViewController, searchViewController, downloadViewController)
            return controller
        }
        
        
        return container
    }
    
}
