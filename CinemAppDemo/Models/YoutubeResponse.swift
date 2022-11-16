//
//  YoutubeResponse.swift
//  CinemAppDemo
//
//  Created by Илья Жариков on 15.11.2022.
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
