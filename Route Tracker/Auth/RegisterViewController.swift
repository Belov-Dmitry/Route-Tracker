//
//  RegisterViewController.swift
//  Route Tracker
//
//  Created by Dmitry Belov on 10.11.2022.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var newLogin: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newRegisterButten: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newRegisterButten.layer.cornerRadius = newRegisterButten.frame.height / 2
        newRegisterButten.layer.masksToBounds = true
    }
    
    @IBAction func newRegister(_ sender: Any) {
        guard
            let login = newLogin.text,
            let password = newPassword.text,
            newPassword.text != "",
            newLogin.text != ""
        else {
            let alert = UIAlertController(title: "Ошибка",
                                          message: "Логин/пароль не верны!",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ОК",
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let userModelRealm = UserModelRealm()
        userModelRealm.addUserData(login: login, password: password) {
            let alert = UIAlertController(title: "Ура!",
                                          message: "Пользователь добавлен!",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ОК",
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
  

}
