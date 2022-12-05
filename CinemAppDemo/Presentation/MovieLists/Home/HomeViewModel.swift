//

import Foundation

protocol HomeViewModel {
    func getTrendingMovies() -> [Title]
    func getTrendingTvShows() -> [Title]
    func getPopularMovies() -> [Title]
    func getUpcomingMovies() -> [Title]
    func getTopRatedMovies() -> [Title]
    func getRandomTrendingTitle() -> Title?

    
    func getSectionCount() -> Int
    func getSectionTitle(_ index: Int) -> String
}

class HomeViewModelImpl : HomeViewModel {
    private let trendingTitlesUseCases: TrendingTitlesUseCases
    private let popularTitlesUseCases: PopularTitlesUseCases
    private let upcomingTitlesUseCases: UpcomingTitlesUseCases
    private let topRatedTitlesUseCases: TopRatedTitlesUseCases
    
    init(
        trendingTitlesUseCases: TrendingTitlesUseCases,
        popularTitlesUseCases: PopularTitlesUseCases,
        upcomingTitlesUseCases: UpcomingTitlesUseCases,
        topRatedTitlesUseCases: TopRatedTitlesUseCases
    ) {
        self.trendingTitlesUseCases = trendingTitlesUseCases
        self.popularTitlesUseCases = popularTitlesUseCases
        self.upcomingTitlesUseCases = upcomingTitlesUseCases
        self.topRatedTitlesUseCases = topRatedTitlesUseCases
    }
    
    func getTrendingMovies() -> [Title] {
        return trendingTitlesUseCases.getTrendingMovies()
    }
    
    func getTrendingTvShows() -> [Title] {
        return trendingTitlesUseCases.getTrendingTvShows()
    }
    
    func getPopularMovies() -> [Title] {
        return popularTitlesUseCases.getPopularMovies()
    }
    
    func getUpcomingMovies() -> [Title] {
        return upcomingTitlesUseCases.getUpcomingTitles()
    }
    
    func getTopRatedMovies() -> [Title] {
        return topRatedTitlesUseCases.getTopRatedMovies()
    }
    
    func getRandomTrendingTitle() -> Title? {
        return trendingTitlesUseCases.getRandomTitle()
    }
    
    func getSectionCount() -> Int {
        return Sections.getCount()
    }
    
    func getSectionTitle(_ index: Int) -> String {
        return Sections.getSectionTitle(index)
    }
}
