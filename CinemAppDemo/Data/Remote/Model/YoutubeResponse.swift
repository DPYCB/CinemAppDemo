//

import Foundation

struct YoutubeSearchResponse : Codable {
    let items: [YoutubeVideo]
}

struct YoutubeVideo: Codable {
    let id: YoutubeVideoId
}

struct YoutubeVideoId: Codable {
    let kind: String
    let videoId: String
}
