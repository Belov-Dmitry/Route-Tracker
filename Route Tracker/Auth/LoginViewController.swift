//
//  LoginViewController.swift
//  Route Tracker
//
//  Created by Dmitry Belov on 09.11.2022.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {

    enum Constants {
        static let login = "admin"
        static let password = "123456"
    }
    
    @IBOutlet weak var loginView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let userModelRealm = UserModelRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.bool(forKey: "isLogin"))
        //UserDefaults.standard.set(false, forKey: "isLogin")
        print(UserDefaults.standard.bool(forKey: "isLogin"))
        
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.layer.masksToBounds = true
        registerButton.layer.cornerRadius = registerButton.frame.height / 2
        registerButton.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "isLogin") {
            performSegue(withIdentifier: "toMain", sender: self)
        }
    }
    

    @IBAction func login(_ sender: Any) {
        guard
            let login = loginView.text,
            let password = passwordView.text,
            //login == Constants.login && password == Constants.password
            loginView.text != "",
            passwordView.text != ""
        else {
            let alert = UIAlertController(title: "Ошибка",
                                          message: "Логин/пароль не верны",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ОК",
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        return
        }
        userModelRealm.getSpecificUserData(for: login) { userData in
            guard let userData = userData
            else {
                let alert = UIAlertController(title: "Ошибка",
                                              message: "Логин/пароль не верны",
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ОК",
                                              style: UIAlertAction.Style.default,
                                              handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            if password == userData.password {
                UserDefaults.standard.set(true, forKey: "isLogin")
                performSegue(withIdentifier: "toMain", sender: sender)
            }  else {
                    let alert = UIAlertController(title: "Ошибка",
                                                  message: "Логин/пароль не верны",
                                                  preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ОК",
                                                  style: UIAlertAction.Style.default,
                                                  handler: nil))
                    self.present(alert, animated: true, completion: nil)
                 return
                }
            }

        
        
    }
    
    @IBAction func register(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: sender)
    
    }
    
    

//    @IBAction func logOut(_ sender: UIStoryboardSegue) {
//        UserDefaults.standard.set(false, forKey: "isLogin")
//        print("---------------------------------------------")
//    }
}
