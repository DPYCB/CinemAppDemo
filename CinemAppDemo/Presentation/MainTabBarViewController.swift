//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let upcomingViewController = UINavigationController(rootViewController: UpcomingViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let downloadViewController = UINavigationController(rootViewController: DownloadViewController())
        
        setupViewControllerStyle(viewController: homeViewController, imageSystemName: "house", title: "Home")
        setupViewControllerStyle(viewController: upcomingViewController, imageSystemName: "play.circle", title: "Upcoming")
        setupViewControllerStyle(viewController: searchViewController, imageSystemName: "magnifyingglass", title: "Search")
        setupViewControllerStyle(viewController: downloadViewController, imageSystemName: "arrow.down.to.line", title: "Downloads")

        tabBar.tintColor = .label
        
        setViewControllers([homeViewController, upcomingViewController, searchViewController, downloadViewController], animated: true)
    }
    
    private func setupViewControllerStyle(viewController: UIViewController, imageSystemName: String, title: String) {
        viewController.tabBarItem.image = UIImage(systemName: imageSystemName)
        viewController.title = title
    }
}
