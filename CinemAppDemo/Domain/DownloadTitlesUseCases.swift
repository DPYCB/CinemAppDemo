//

import Foundation

protocol DownloadTitlesUseCases {
    func downloadTitle(title: Title)
    func deleteDownloadedTitle(title: TitleEntity)
    func updateDownloads() -> [TitleEntity]
}
