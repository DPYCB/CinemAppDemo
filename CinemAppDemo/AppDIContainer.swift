//

import Foundation
import Swinject

final class AppDIContainer {
    static let instance: Container = {
        let container = Container()
        container.register(DatabaseManager.self) { _ in DatabaseManager.instance}
        container.register(APICaller.self) { _ in APICaller.instance}
        
        container.register(TitlesRepository.self) { r in
            TitlesRepositoryImpl(titlesDatabase: r.resolve(DatabaseManager.self)!, titlesApi: r.resolve(APICaller.self)!)
        }
        
        registerUseCases(container: container)
        registerHomeScreen(container: container)
        registerUpcomingScreen(container: container)
        registerSearchScreen(container: container)
        registerDownloadsScreen(container: container)
        registerMainTabs(container: container)
        
        return container
    }()
    
    private static func registerUseCases(container: Container) {
        container.register(PopularTitlesUseCases.self) { r in
            PopularTitlesUseCasesImpl(titlesRepository: r.resolve(TitlesRepository.self)!)
        }
        container.register(UpcomingTitlesUseCases.self) { r in
            UpcomingTitlesUseCasesImpl(titlesRepository: r.resolve(TitlesRepository.self)!)
        }
        container.register(TrendingTitlesUseCases.self) { r in
            TrendingTitlesUseCasesImpl(titlesRepository: r.resolve(TitlesRepository.self)!)
        }
        container.register(TopRatedTitlesUseCases.self) { r in
            TopRatedTitlesUseCasesImpl(titlesRepository: r.resolve(TitlesRepository.self)!)
        }
        container.register(DownloadTitlesUseCases.self) { r in
            DownloadTitlesUseCasesImpl(titlesRepository: r.resolve(TitlesRepository.self)!)
        }
    }
    
    private static func registerHomeScreen(container: Container) {
        container.register(HomeViewModel.self) { r in
            let trendingTitlesUseCases = r.resolve(TrendingTitlesUseCases.self)!
            let popularTitlesUseCases = r.resolve(PopularTitlesUseCases.self)!
            let upcomingTitlesUseCases = r.resolve(UpcomingTitlesUseCases.self)!
            let topRatedTitlesUseCases = r.resolve(TopRatedTitlesUseCases.self)!
            return HomeViewModelImpl(
                trendingTitlesUseCases: trendingTitlesUseCases,
                popularTitlesUseCases: popularTitlesUseCases,
                upcomingTitlesUseCases: upcomingTitlesUseCases,
                topRatedTitlesUseCases: topRatedTitlesUseCases
            )
        }
        container.register(HomeViewController.self) { r in
            HomeViewController(nibName: nil, bundle: nil, r.resolve(HomeViewModel.self)!)
        }
    }
    
    private static func registerUpcomingScreen(container: Container) {
        container.register(UpcomingViewController.self) { _ in
            UpcomingViewController()
        }
    }
    
    private static func registerSearchScreen(container: Container) {
        container.register(SearchViewController.self) { _ in
            SearchViewController()
        }
    }
    
    private static func registerDownloadsScreen(container: Container) {
        container.register(DownloadsViewModel.self) { r in
            DownloadsViewModelImpl(downloadTitlesUseCases: r.resolve(DownloadTitlesUseCases.self)!)
        }
        container.register(DownloadViewController.self) { r in
            DownloadViewController(nibName: nil, bundle: nil, r.resolve(DownloadsViewModel.self)!)
        }
    }
    
    private static func registerMainTabs(container: Container) {
        container.register(MainTabBarViewController.self) { r in
            let homeViewController = r.resolve(HomeViewController.self)!
            let upcomingViewController = r.resolve(UpcomingViewController.self)!
            let searchViewController = r.resolve(SearchViewController.self)!
            let downloadViewController = r.resolve(DownloadViewController.self)!
            return MainTabBarViewController(
                nibName: "MainTabViewController",
                bundle: nil, homeViewController,
                upcomingViewController,
                searchViewController,
                downloadViewController
            )
        }
    }
}
