//
//  EditUserDataViewController.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 29.05.2022.
//

import UIKit

class EditUserDataViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var genderSegmented: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var aboutUserTextField: UITextField!
    
    // MARK: - Propreties
    
    let requestFactory = RequestFactory()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rightNavButton()
    }
    
    // MARK: - IBAcion
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if isFormFilled() {
            fetchData()
        } else {
            presentAlert(title: "Ошибка", message: "Заполните все поля!", actionTitles: ["OK"], actionStyle: [.default], actions: [nil])
        }
    }
    
    // MARK: - OBJ-C Func
    
    @objc func signoutButtonTapped(sender: UIButton) {
        signout()
    }
}

// MARK: - Private Func

extension EditUserDataViewController {
    
    private func fetchData() {
        view.showSpinner()
        let factory = requestFactory.makeChangeUserDataRequestFactory()
        let user = User(id: Int.random(in: 1...100),
                        login: loginTextField.text,
                        password: passwordTextField.text,
                        email: emailTextField.text,
                        gender: genderSegmented.selectedSegmentIndex == 0 ? "M" : "F",
                        bio: aboutUserTextField.text,
                        name: nameTextField.text,
                        lastname: surnameTextField.text)
        
        factory.changeUserData(user: user) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let success): success.result == 1 ? self.fetchDataSuccess() : self.fetchDataError(message: success.errorMessage ?? "Неизвестная ошибка.")
                    self.view.dismissSpinner()
                case .failure(let error): self.fetchDataError(message: error.localizedDescription)
                    self.view.dismissSpinner()
                }
            }
        }
    }
    
    private func signout() {
        changeRootVCWithNavController(identifier: "AuthNav")
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
        presentAlert(title: "Отлично!", message: "Ваши данные изменены!", actionTitles: ["OK"], actionStyle: [.default], actions: [nil])
    }
    
    private func fetchDataError(message: String) {
        presentAlert(title: "Ошибка", message: message, actionTitles: ["OK"], actionStyle: [.default], actions: [nil])
    }
    
    
    private func rightNavButton() {
        let refreshButton =  UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(signoutButtonTapped))
        navigationItem.rightBarButtonItem = refreshButton
    }
}
