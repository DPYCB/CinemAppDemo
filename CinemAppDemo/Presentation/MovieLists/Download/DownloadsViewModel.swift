//

import Foundation

protocol DownloadsViewModel {
    func deleteDownload(itemId: Int)
    func getDownloadsCount() -> Int
    func updateDownloads()
    func getTitleViewState(itemId: Int) -> TitleViewState?
}
