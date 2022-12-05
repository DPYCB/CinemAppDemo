//

import Foundation

protocol TopRatedTitlesUseCases {
    func getTopRatedMovies() -> [Title]
}

class TopRatedTitlesUseCasesImpl: TopRatedTitlesUseCases {
    private let titlesRepository: TitlesRepository
    
    init(titlesRepository: TitlesRepository) {
        self.titlesRepository = titlesRepository
    }
    
    func getTopRatedMovies() -> [Title] {
        var resultTitles = [Title]()
        titlesRepository.requestTopRatedMovies { result in
            switch result {
            case.success(let titles):
                resultTitles = titles
            case.failure(let error):
                print("couldn't fetch top rated movies: " + error.localizedDescription)
            }
        }
        return resultTitles
    }
}
