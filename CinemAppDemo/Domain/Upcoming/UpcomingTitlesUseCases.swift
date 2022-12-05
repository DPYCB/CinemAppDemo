//

import Foundation

protocol UpcomingTitlesUseCases {
    func getUpcomingTitles() -> [Title]
}

class UpcomingTitlesUseCasesImpl : UpcomingTitlesUseCases {
    private let titlesRepository: TitlesRepository
    
    init(titlesRepository: TitlesRepository) {
        self.titlesRepository = titlesRepository
    }
    
    func getUpcomingTitles() -> [Title] {
        var resultTitles = [Title]()
        titlesRepository.requestUpcomingMovies { result in
            switch result {
            case.success(let titles):
                resultTitles = titles
            case.failure(let error):
                print("couldn't fetch upcoming movies: " + error.localizedDescription)
            }
        }
        return resultTitles
    }
}
