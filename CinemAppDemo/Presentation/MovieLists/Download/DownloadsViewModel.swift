//

import Foundation

protocol DownloadsViewModel {
    func deleteDownload(itemId: Int)
    func getDownloadsCount() -> Int
    func updateDownloads()
    func getTitleViewState(itemId: Int) -> TitleViewState?
}

class DownloadsViewModelImpl : DownloadsViewModel {
    private let downloadTitlesUseCases: DownloadTitlesUseCases
    private var titles: [TitleEntity] = [TitleEntity]()

    init(downloadTitlesUseCases: DownloadTitlesUseCases) {
        self.downloadTitlesUseCases = downloadTitlesUseCases
    }
    
    func deleteDownload(itemId: Int) {
        downloadTitlesUseCases.deleteDownloadedTitle(title: titles[itemId])
        titles.remove(at: itemId)
    }
    
    func updateDownloads() {
        titles = downloadTitlesUseCases.updateDownloads()
    }
    
    func getDownloadsCount() -> Int {
        return titles.count
    }
    
    func getTitleViewState(itemId: Int) -> TitleViewState? {
        let title = titles[itemId]
        let titleName = title.original_name ?? title.original_title ?? ""
        guard let posterPath = title.poster_path else { return nil }
        return TitleViewState(titleName: titleName, posterUrlPath: posterPath)
    }
}
