//
//  SignUpViewController.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 29.05.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var adoutUserTextField: UITextField!
    
    // MARK: - Propreties
    
    let requestFactory = RequestFactory()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - IBAcion
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        if isFormFilled() {
            fetchData()
        } else {
            presentAlert(title: "Ошибка", message: "Заполните все поля!", actionTitles: ["OK"], actionStyle: [.default], actions: [nil])
        }
    }
}

// MARK: - Private Func

extension SignUpViewController {
    
    private func fetchData() {
        view.showSpinner()
        let factory = requestFactory.makeSignupRequestFactory()
        let user = User(id: Int.random(in: 1...100),
                        login: loginTextField.text,
                        password: passwordTextField.text,
                        email: emailTextField.text,
                        gender: genderSegment.selectedSegmentIndex == 0 ? "M" : "F",
                        bio: adoutUserTextField.text,
                        name: nameTextField.text,
                        lastname: surnameTextField.text)
        
        factory.signup(user: user) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let success): success.result == 1 ? self.fetchDataSuccess() : self.fetchDataError(message: "Возможно пользователь, с таким логином, уже существует")
                    self.view.dismissSpinner()
                case .failure(let error): self.fetchDataError(message: error.localizedDescription)
                    self.view.dismissSpinner()
                }
            }
        }
    }
    
    private func isFormFilled() -> Bool {
        guard nameTextField.text != "",
              surnameTextField.text != "",
              emailTextField.text != "",
              loginTextField.text != "",
              passwordTextField.text != "" else {
            return false
        }
        return true
    }
    
    private func fetchDataSuccess() {
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchDataError(message: String) {
        presentAlert(title: "Ошибка", message: message, actionTitles: ["OK"], actionStyle: [.default], actions: [nil])
    }
}
