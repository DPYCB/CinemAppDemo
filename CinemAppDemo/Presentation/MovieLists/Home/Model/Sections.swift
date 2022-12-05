//

import Foundation

struct Sections {
    struct SetctionItem {
        let id: Int
        let name: String
    }
    private static let sections = [
        SetctionItem(id: 0, name: "Trending Movies"),
        SetctionItem(id: 1, name: "Trending TV"),
        SetctionItem(id: 2, name: "Popular"),
        SetctionItem(id: 3, name: "Upcoming Movies"),
        SetctionItem(id: 4, name: "Top Rated")
    ]
    static let TrendingMovies = sections[0]
    static let TrendingTV = sections[1]
    static let Popular = sections[2]
    static let UpcomingMovies = sections[3]
    static let TopRated = sections[4]
    
    static func getCount() -> Int {
        return sections.count
    }
    
    static func getSectionTitle(_ index: Int) -> String {
        return sections[index].name
    }
}
