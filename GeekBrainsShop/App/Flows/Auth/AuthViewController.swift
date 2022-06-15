//
//  AuthViewController.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 29.05.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Propreties
    
    let requestFactory = RequestFactory()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAcion
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if isFormFilled() {
            fetchData()
        } else {
            presentAlert(title: "Ошибка", message: "Введите логин/пароль", actionTitles: ["OK"], actionStyle: [.default], actions: [nil])
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        goToSignUpController()
    }
}

// MARK: - Private Func

extension AuthViewController {
    
    private func fetchData() {
        view.showSpinner()
        let factory = requestFactory.makeAuthRequestFactory()
        let user = User(login: loginTextField.text, password: passwordTextField.text)
        
        factory.login(user: user) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let success): success.result == 1 ? self.fetchDataSuccess() : self.fetchDataError(message: "Неправильный логин или пароль")
                    GALogger.logEvent(name: "login", key: "result", value: "success")
                    self.view.dismissSpinner()
                case .failure(let error): self.fetchDataError(message: error.localizedDescription)
                    GALogger.logEvent(name: "login", key: "result", value: "failure")
                    self.view.dismissSpinner()
                }
            }
        }
    }
    
    private func isFormFilled() -> Bool {
        guard loginTextField.text != "",
              passwordTextField.text != "" else {
            return false
        }
        return true
    }
    
    private func goToSignUpController() {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchDataSuccess() {
        changeRootVCWithNavController(identifier: "SuccessAuthNav")
    }
    
    private func fetchDataError(message: String) {
        presentAlert(title: "Ошибка", message: message, actionTitles: ["OK"], actionStyle: [.default], actions: [nil])
    }
}
