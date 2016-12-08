import Foundation
import Firebase

class DatabaseAdapter {
    let uid = FIRAuth.auth()?.currentUser?.uid
    
    let base = FIRDatabase.database().reference(fromURL: "https://cancercarenew.firebaseio.com/")
    
    func insert(key: String, path: String, values: [String: AnyObject], completion: ()?){
        let ref = base.child(path).child(key)
        ref.updateChildValues(values){ _,_ in
            completion
        }
    }
    
    func delete(key: String, path: String){
        self.delete(key: key, path: path, completion: nil)
    }
    
    func delete(key: String, path: String, completion: ()?){
        let ref = base.child(path).child(key)
        ref.removeValue{ (error, _) in
                completion
        }
    }
    
    
    func fetchDict(key: String, path: String, completion: @escaping ([String:AnyObject]) -> Void){
        self.fetchDict(key: key, orderBy: nil, path: path, completion: completion)
    }
    
    func fetchDict(key: String, orderBy: String?, path: String, completion: @escaping ([String:AnyObject]) -> Void){
        var result: [String:String] = [:]
        var ref: FIRDatabaseQuery
        
        if orderBy != nil {
            ref = base.child("\(path)/\(key)/").queryOrdered(byChild: orderBy!)
        } else {
            ref = base.child("\(path)/\(key)/")
        }
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists(){
                completion([String:AnyObject]())
            } else {
                for snap in snapshot.children.allObjects {
                    var val = ""
                    let key = (snap as AnyObject).key!!
                        val = (snap as AnyObject).value!!
                    
                    
                    result.updateValue(val, forKey: key)
                }
                completion(result as [String : AnyObject])
            }
            return
        })
        
    }
    
    func fetchKeys(path: String, completion: (([String]) -> Void)?){
        var result: [String] = []
        let ref = base.child(path)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists(){
                completion?([String]())
            } else {
                for snap in snapshot.children.allObjects {
                    let mainKey = (snap as AnyObject).key!!
                    result.append(mainKey)
                }
                completion?(result)
            }
            return
        })
    }
    
}


