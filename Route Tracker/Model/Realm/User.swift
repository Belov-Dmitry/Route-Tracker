//
//  User.swift
//  Route Tracker
//
//  Created by Dmitry Belov on 10.11.2022.
//

import Foundation
import RealmSwift

class UserModelRealm: Object, Decodable {
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    
    override class func primaryKey() -> String? {
            return "login"
        }
    
    
    func addUserData(login: String, password: String, completionHandler: () -> ()) {
            do {
                let realm = try Realm()
                realm.beginWrite()
                let userData = UserModelRealm()
                userData.login = login
                userData.password = password
                realm.add(userData, update: .modified)
                
                try realm.commitWrite()
                completionHandler()
                print("++++++++++++++++++++++++++++++++++++++++++")
                print(realm.configuration.fileURL)
            } catch {
                print(error)
            }
        }
    
    func getSpecificUserData(for primaryKey: String, completionHandler: (UserModelRealm?) -> ()) {
            var specificUserData: UserModelRealm?
            do {
                let realm = try Realm()
                specificUserData = realm.object(ofType: UserModelRealm.self, forPrimaryKey: primaryKey)
                completionHandler(specificUserData)
            } catch {
                print(error)
            }
        }
    
}
