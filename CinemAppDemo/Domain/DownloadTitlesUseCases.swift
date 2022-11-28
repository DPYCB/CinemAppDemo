//

import Foundation

class DownloadTitlesUseCases {
    private let titlesRepository = TitlesRepositoryImpl()
    
    func downloadTitle(title: Title) {
        titlesRepository.downloadTitle(title: title) { result in
            switch result {
            case.success():
                let notificationName = NSNotification.Name("Downloaded")
                NotificationCenter.default.post(name: notificationName, object: nil)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteDownloadedTitle(title: TitleEntity) {
        titlesRepository.deleteDownload(with: title) { result in
            switch result {
            case.failure(let error):
                //TODO implement toast
                print(error.localizedDescription)
            default:
                break
            }
        }
    }
    
    func getDownloads() -> [TitleEntity] {
        var downloads = [TitleEntity]()
        titlesRepository.getDownloads { result in
            switch result {
            case.success(let titles):
                downloads = titles
            case.failure(let error):
                //TODO implement toast
                print(error.localizedDescription)
            }
        }
        return downloads
    }
}
