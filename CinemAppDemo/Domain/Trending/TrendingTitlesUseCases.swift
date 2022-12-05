//

import Foundation

protocol TrendingTitlesUseCases {
    func getTrendingMovies() -> [Title]
    func getTrendingTvShows() -> [Title]
    func getRandomTitle() -> Title?
}

class TrendingTitlesUseCasesImpl: TrendingTitlesUseCases {
    private let titlesRepository: TitlesRepository
    
    init(titlesRepository: TitlesRepository) {
        self.titlesRepository = titlesRepository
    }
    
    func getTrendingMovies() -> [Title] {
        var resultTitles = [Title]()
        titlesRepository.requestTrendingMovies { result in
            switch result {
            case.success(let titles):
                resultTitles = titles
            case.failure(let error):
                print("couldn't fetch trending movies: " + error.localizedDescription)
            }
        }
        return resultTitles
    }
    
    func getTrendingTvShows() -> [Title] {
        var resultTitles = [Title]()
        titlesRepository.requestTrendingMovies { result in
            switch result {
            case.success(let titles):
                resultTitles = titles
            case.failure(let error):
                print("couldn't fetch trending tv shows: " + error.localizedDescription)
            }
        }
        return resultTitles
    }
    
    func getRandomTitle() -> Title? {
        return (getTrendingMovies() + getTrendingTvShows()).randomElement()
    }
}
