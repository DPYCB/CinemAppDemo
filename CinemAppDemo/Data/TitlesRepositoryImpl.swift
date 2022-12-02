//

import Foundation

class TitlesRepositoryImpl: TitlesRepository {
    private let titlesDatabase: DatabaseManager
    private let titlesApi: APICaller
    
    init(titlesDatabase: DatabaseManager, titlesApi: APICaller) {
        self.titlesDatabase = titlesDatabase
        self.titlesApi = titlesApi
    }
    
    func downloadTitle(title: Title, onComplete: @escaping (Result<Void, Error>) -> Void) {
        titlesDatabase.downloadTitle(model: title, onComplete: onComplete)
    }
    
    func getDownloads(onComplete: @escaping (Result<[TitleEntity], Error>) -> Void) {
        titlesDatabase.getTitles(onComplete: onComplete)
    }
    
    func deleteDownload(with title: TitleEntity, onComplete: @escaping (Result<Void, Error>) -> Void) {
        titlesDatabase.deleteTitle(with: title, onComplete: onComplete)
    }
    
    func requestTrendingMovies(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        titlesApi.getTrendingMovies(onComplete: onComplete)
    }
    
    func requestTrendingTvShows(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        titlesApi.getTrendingTvShows(onComplete: onComplete)
    }
    
    func requestPopularMovies(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        titlesApi.getPopularMovies(onComplete: onComplete)
    }
    
    func requestUpcomingMovies(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        titlesApi.getUpcomingMovies(onComplete: onComplete)
    }
    
    func requestTopRatedMovies(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        titlesApi.getTopRatedMovies(onComplete: onComplete)
    }
    
    func requestDiscoverMovies(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        titlesApi.getDiscoverMovies(onComplete: onComplete)
    }
    
    func searchTitles(with query: String, onComplete: @escaping (Result<[Title], Error>) -> Void) {
        titlesApi.search(with: query, onComplete: onComplete)
    }
    
    func searchMovieTrailer(with query: String, onComplete: @escaping (Result<YoutubeVideo, Error>) -> Void) {
        titlesApi.searchMovieTrailer(with: query, onComplete: onComplete)
    }
}
