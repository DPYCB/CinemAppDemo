//

import Foundation

protocol PopularTitlesUseCases {
    func getPopularMovies() -> [Title]
}

class PopularTitlesUseCasesImpl: PopularTitlesUseCases {
    private let titlesRepository: TitlesRepository
    
    init(titlesRepository: TitlesRepository) {
        self.titlesRepository = titlesRepository
    }
    
    func getPopularMovies() -> [Title] {
        var resultTitles = [Title]()
        titlesRepository.requestPopularMovies { result in
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
