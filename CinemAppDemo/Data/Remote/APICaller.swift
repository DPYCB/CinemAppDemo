//

import Foundation

struct Companion {
    static let YOUTUBE_API_KEY = "AIzaSyAMzbAD3PcoGP0oox5aWQEXFUUyvBEChQQ"
    static let YOUTUBE_BASE_URL = "https://youtube.googleapis.com/youtube/v3/search"
    static let TMDB_API_KEY = "3f9255aa7214d5b595af01772145e351"
    static let TMDB_BASE_URL = "https://api.themoviedb.org/3/"
    static let POSTER_BASE_URL = "https://image.tmdb.org/t/p/w342"
}

class APICaller {
    enum APIError: Error {
        case FailedToFetchData
    }
    
    static let instance = APICaller()
    
    static func getPosterUrl(posterPath: String) -> URL? {
        return URL(string: Companion.POSTER_BASE_URL + posterPath)
    }
    
    private func requestMovies(urlString: String, onComplete: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TitlesResponse.self, from: data)
                onComplete(.success(result.results))
            }
            catch {
                onComplete(.failure(APIError.FailedToFetchData))
            }
        }
        task.resume()
    }
    
    private func requestMovies(urlString: String, onComplete: @escaping (Result<YoutubeVideo, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                onComplete(.success(result.items[0]))
            }
            catch {
                print(error.localizedDescription)
                onComplete(.failure(APIError.FailedToFetchData))
            }
        }
        task.resume()
    }
        
    private func buildTmdbUrlString(category: String, contentType: String, searchQuery: String = "") -> String {
        let searchParam = !searchQuery.isEmpty ? "&query=\(searchQuery)" : ""
        return "\(Companion.TMDB_BASE_URL)/\(category)/\(contentType)?api_key=\(Companion.TMDB_API_KEY)" + searchParam
    }
    
    private func buildYoutubeUrlString(category: String, searchQuery: String = "") -> String {
        let searchParam = !searchQuery.isEmpty ? "?q=\(searchQuery)" : ""
        return "\(Companion.YOUTUBE_BASE_URL)\(searchParam)&key=\(Companion.YOUTUBE_API_KEY)"
    }
    
    func getTrendingMovies(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        requestMovies(urlString: buildTmdbUrlString(category: "trending", contentType: "movie/day"), onComplete: onComplete)
    }
    
    func getTrendingTvShows(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        requestMovies(urlString: buildTmdbUrlString(category: "trending", contentType: "tv/day"), onComplete: onComplete)
    }
    
    func getPopularMovies(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        requestMovies(urlString: buildTmdbUrlString(category: "movie", contentType: "popular"), onComplete: onComplete)
    }
    
    func getUpcomingMovies(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        requestMovies(urlString: buildTmdbUrlString(category: "movie", contentType: "upcoming"), onComplete: onComplete)
    }
    
    func getTopRatedMovies(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        requestMovies(urlString: buildTmdbUrlString(category: "movie", contentType: "top_rated"), onComplete: onComplete)
    }
    
    func getDiscoverMovies(onComplete: @escaping (Result<[Title], Error>) -> Void) {
        requestMovies(urlString: buildTmdbUrlString(category: "discover", contentType: "movie"), onComplete: onComplete)
    }
    
    func search(with query: String, onComplete: @escaping (Result<[Title], Error>) -> Void) {
        guard let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        requestMovies(urlString: buildTmdbUrlString(category: "search", contentType: "movie", searchQuery: formattedQuery), onComplete: onComplete)
    }
    
    func searchMovieTrailer(with query: String, onComplete: @escaping (Result<YoutubeVideo, Error>) -> Void) {
        guard let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        requestMovies(urlString: buildYoutubeUrlString(category: "search", searchQuery: formattedQuery), onComplete: onComplete)
    }
}
