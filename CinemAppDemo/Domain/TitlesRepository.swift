//

import Foundation
protocol TitlesRepository {
    func downloadTitle(title: Title, onComplete: @escaping (Result<Void, Error>) -> Void)
    func getDownloads(onComplete: @escaping (Result<[TitleEntity], Error>) -> Void)
    func deleteDownload(with title: TitleEntity, onComplete: @escaping (Result<Void, Error>) -> Void)
    func requestTrendingMovies(onComplete: @escaping (Result<[Title], Error>) -> Void)
    func requestTrendingTvShows(onComplete: @escaping (Result<[Title], Error>) -> Void)
    func requestPopularMovies(onComplete: @escaping (Result<[Title], Error>) -> Void)
    func requestUpcomingMovies(onComplete: @escaping (Result<[Title], Error>) -> Void)
    func requestTopRatedMovies(onComplete: @escaping (Result<[Title], Error>) -> Void)
    func requestDiscoverMovies(onComplete: @escaping (Result<[Title], Error>) -> Void)
    func searchTitles(with query: String, onComplete: @escaping (Result<[Title], Error>) -> Void)
    func searchMovieTrailer(with query: String, onComplete: @escaping (Result<YoutubeVideo, Error>) -> Void)
}
