//
//  DetailPresenter.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 21/12/20.
//

import UIKit
import CoreData

protocol DetailDelegate {
    func loadDetailSuccess(model: ResponseDetail)
    func loadDetailFail(error: String)
    
    func isModelSaved(status: Bool)
    
    func isSaveModelSuccess(status: Bool)
    func isRemoveModelSuccess(status: Bool)
}

class DetailPresenter {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private var delegate: DetailDelegate
    
    var isFavoriteStatus = false
    
    init(delegate: DetailDelegate) {
        self.delegate = delegate
    }
    
    func fetchDetailMovie(id: Int) {
        let strUrl = K.URL.BASE_URL_API + String(describing: id) + K.URL.END_URL
        
        let url = URL(string: strUrl)!
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let err = error {
                self.delegate.loadDetailFail(error: err.localizedDescription)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(ResponseDetail.self, from: data!)
                self.delegate.loadDetailSuccess(model: json)
            } catch {
                self.delegate.loadDetailFail(error: "Error during JSON serialization: \(error.localizedDescription)")
                
            }
        }).resume()
    }
    
    private func saveToFavorite(_ model: MovieModel) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: K.Core.entityMovie, in: managedContext) else {return}
            
            let insert = NSManagedObject(entity: entity, insertInto: managedContext)
            insert.setValue(model.id, forKey: K.Core.id)
            insert.setValue(model.title, forKey: K.Core.title)
            insert.setValue(model.overview, forKey: K.Core.overview)
            insert.setValue(model.release_date, forKey: K.Core.releaseDate)
            insert.setValue(model.poster_path, forKey: K.Core.posterPath)
            insert.setValue(model.backdrop_path, forKey: K.Core.backdropPath)
            
            do {
                try managedContext.save()
                
                isFavoriteStatus = true
                delegate.isModelSaved(status: true)
            } catch let err {
                print("Error Saved To Favorite: ", err.localizedDescription)
            }
        }
    }
    
    private func removeFromFavorite(id: Int) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityMovie)
            fetchRequest.predicate = NSPredicate(format: "\(K.Core.id) = %ld", id)
            
            do {
                let fetch = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                
                if fetch.isEmpty {return}
                
                for f in fetch {
                    managedContext.delete(f)
                }
                
                try managedContext.save()
                
                isFavoriteStatus = false
                delegate.isRemoveModelSuccess(status: true)
            } catch let err {
                print("Error Removed From Favorite: ", err.localizedDescription)
            }
        }
    }
    
    func isFavorite(_ model: MovieModel) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityMovie)
            fetchRequest.predicate = NSPredicate(format: "\(K.Core.id) = %ld", model.id)
            
            do {
                let fetch = try managedContext.fetch(fetchRequest)
                
                if !fetch.isEmpty {
                    isFavoriteStatus = true
                }
            } catch let err {
                print("Error Check isFavorite: ", err.localizedDescription)
            }
        }
        
        delegate.isModelSaved(status: isFavoriteStatus)
    }
    
    func saveOrRemove(model: MovieModel) {
        if isFavoriteStatus {
            removeFromFavorite(id: model.id)
        } else {
            saveToFavorite(model)
        }
    }
}
