//

import UIKit

class MainTabBarViewController: UITabBarController {
    private let homeViewController: HomeViewController
    private let upcomingViewController: UpcomingViewController
    private let searchViewController: SearchViewController
    private let downloadViewController: DownloadViewController
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, _ homeViewController: HomeViewController, _ upcomingViewController: UpcomingViewController, _ searchViewController: SearchViewController, _ downloadViewController: DownloadViewController) {
        self.homeViewController = homeViewController
        self.upcomingViewController = upcomingViewController
        self.searchViewController = searchViewController
        self.downloadViewController = downloadViewController
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeNavController = UINavigationController(rootViewController: homeViewController)
        let upcomingNavController = UINavigationController(rootViewController:upcomingViewController)
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        let downloadNavController = UINavigationController(rootViewController:downloadViewController)
        setupViewControllerStyle(viewController: homeNavController, imageSystemName: "house", title: "Home")
        setupViewControllerStyle(viewController: upcomingNavController, imageSystemName: "play.circle", title: "Upcoming")
        setupViewControllerStyle(viewController: searchNavController, imageSystemName: "magnifyingglass", title: "Search")
        setupViewControllerStyle(viewController: downloadNavController, imageSystemName: "arrow.down.to.line", title: "Downloads")

        tabBar.tintColor = .label
                
        setViewControllers([homeNavController, upcomingNavController, searchNavController, downloadNavController], animated: true)
    }
    
    private func setupViewControllerStyle(viewController: UIViewController, imageSystemName: String, title: String) {
        viewController.tabBarItem.image = UIImage(systemName: imageSystemName)
        viewController.title = title
    }
}

