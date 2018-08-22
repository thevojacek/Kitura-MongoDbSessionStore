import Foundation
import MongoKitten
import KituraSession


enum KituraMongoDbSessionStoreError: Error {
    
    case documentDoesNotExist
    case dataCouldNotBeRetrieved
    
    var localizedDescription: String {
        get {
            switch self {
            case .dataCouldNotBeRetrieved:
                return "Data could not be retrieved."
            case.documentDoesNotExist:
                return "Document does not exist."
            }
        }
    }
}


public class KituraMongoDbSessionStore: Store {
    
    /// Collection to which to store the sessions
    private let collection: MongoKitten.Collection
    
    public init (_ collection: MongoKitten.Collection) {
        self.collection = collection
    }
    
    /// Load the session data.
    ///
    /// - Parameter sessionId: The ID of the session.
    /// - Parameter callback: The closure to invoke once the session data is fetched.
    public func load(sessionId: String, callback: @escaping (Data?, NSError?) -> Void) {
        
        let query: MongoKitten.Query = ["sessionId": sessionId]
        
        do {
            
            guard let document: MongoKitten.Document = try self.collection.findOne(query) else {
                throw KituraMongoDbSessionStoreError.documentDoesNotExist
            }
            
            guard let data = (document["data"] as? String)?.data(using: .utf8) else {
                throw KituraMongoDbSessionStoreError.dataCouldNotBeRetrieved
            }
            
            callback(data, nil)
        } catch {
            callback(nil, self.getNsError(error: error))
        }
    }
    
    /// Save the session data.
    ///
    /// - Parameter sessionId: The ID of the session.
    /// - Parameter data: The data to save.
    /// - Parameter callback: The closure to invoke once the session data is saved.
    public func save(sessionId: String, data: Data, callback: @escaping (NSError?) -> Void) {
        
        let document: MongoKitten.Document = [
            "_id": ObjectId(),
            "sessionId": sessionId,
            "data": String(data: data, encoding: .utf8)
        ]
        
        do {
            try self.collection.insert(document)
            callback(nil)
        } catch {
            callback(self.getNsError(error: error))
        }
    }
    
    /// Touch the session data.
    ///
    /// - Parameter sessionId: The ID of the session.
    /// - Parameter callback: The closure to invoke once the session data is touched.
    public func touch(sessionId: String, callback: @escaping (NSError?) -> Void) {
        
        let query: MongoKitten.Query = ["sessionId": sessionId]
        
        do {
            
            guard try self.collection.findOne(query) != nil else {
                throw KituraMongoDbSessionStoreError.documentDoesNotExist
            }
            
            callback(nil)
        } catch {
            callback(self.getNsError(error: error))
        }
    }
    
    /// Delete the session data.
    ///
    /// - Parameter sessionId: The ID of the session.
    /// - Parameter callback: The closure to invoke once the session data is deleted.
    public func delete(sessionId: String, callback: @escaping (NSError?) -> Void) {
        
        let query: MongoKitten.Query = ["sessionId": sessionId]
        
        do {
            _ = try self.collection.findAndRemove(query, sortedBy: nil, projection: nil)
            callback(nil)
        } catch {
            callback(self.getNsError(error: error))
        }
    }
    
    /// Transforms instance of an Error to NSError
    ///
    /// - Parameter error: Instance of an Error
    /// - Returns: NSError
    private func getNsError (error: Error) -> NSError {
        return NSError(
            domain: "KituraMongoDbSessionStore",
            code: 500,
            userInfo: ["Description": error.localizedDescription]
        )
    }
}

