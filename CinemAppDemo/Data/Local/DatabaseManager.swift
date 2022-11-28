//

import Foundation
import CoreData
import UIKit

class DatabaseManager {
    enum DatabaseError : Error {
        case FailedToSaveData
        case FailedToGetData
        case FailedToDeleteData
    }
    
    static let instance = DatabaseManager()
    
    private func getViewContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        return appDelegate.persistentContainer.viewContext
    }
    
    func downloadTitle(model: Title, onComplete: @escaping (Result<Void, Error>) -> Void) {
        guard let viewContext = getViewContext() else {return}
        let entity = TitleEntity(context: viewContext)
        
        
        entity.id = Int64(model.id)
        entity.original_name = model.original_name
        entity.original_title = model.original_title
        entity.overview = model.overview
        entity.media_type = model.media_type
        entity.poster_path = model.poster_path
        entity.release_date = model.release_date
        entity.vote_count = Int64(model.vote_count)
        entity.vote_average = model.vote_average
        
        do {
            try viewContext.save()
            onComplete(.success(()))
        }
        catch {
            onComplete(.failure(DatabaseError.FailedToSaveData))
        }
    }
    
    func getTitles(onComplete: @escaping (Result<[TitleEntity], Error>) -> Void) {
        guard let viewContext = getViewContext() else {return}
        let databaseRequest: NSFetchRequest<TitleEntity> = TitleEntity.fetchRequest()
        do {
            let titles = try viewContext.fetch(databaseRequest)
            onComplete(.success(titles))
        }
        catch {
            onComplete(.failure(DatabaseError.FailedToGetData))
        }
    }
    
    func deleteTitle(with model: TitleEntity, onComplete: @escaping (Result<Void, Error>) -> Void) {
        guard let viewContext = getViewContext() else {return}
        viewContext.delete(model)
        
        do {
            try viewContext.save()
            onComplete(.success(()))
        }
        catch {
            onComplete(.failure(DatabaseError.FailedToDeleteData))
        }
    }
}
