//
//  TitlePreviewViewModel.swift
//  CinemAppDemo
//
//  Created by DPYCB on 15.11.2022.
//

import Foundation

struct TitlePreviewViewModel {
    private let youtubeVideoBaseUrl = "https://www.youtube.com/embed/"
    
    let title: String
    let youtubeVideo: YoutubeVideo
    let titleOverview: String
    
    func getYoutubeVideoUrlString() -> String {
        return youtubeVideoBaseUrl + youtubeVideo.id.videoId
    }
}
