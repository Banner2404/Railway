//
//  LoginViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/3/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController, BaseViewController {
    @IBOutlet weak var usernameTextField: NSTextField!
    
    @IBOutlet weak var errorMessageLabel: NSTextField!
    @IBOutlet weak var activityIndicator: NSProgressIndicator!
    @IBOutlet weak var passwordTextField: NSTextField!
    @IBOutlet weak var loginButton: NSButton!
    weak var window: NSWindow?
    var state = State.normal {
        didSet {
            stateDidChange()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.stringValue = "admin"
        passwordTextField.stringValue = "bepaid"
        window = NSApplication.shared.windows.first
        validateTextFields()
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        let username = usernameTextField.stringValue
        let password = passwordTextField.stringValue
        state = .authenticating
        requestManager.login(username: username, password: password) { (success, user, error) in
            if success, let user = user  {
                self.userAccountManager.user = user
                self.showAdminWindow()
                self.state = .normal
            } else {
                self.state = .error("Incorrect username or password")
                print(error ?? "")
            }
        }
    }
    
    func stateDidChange() {
        switch state {
        case .normal:
            loginButton.isHidden = false
            activityIndicator.isHidden = true
            errorMessageLabel.isHidden = true
        case .authenticating:
            loginButton.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimation(self)
            errorMessageLabel.isHidden = true
        case .error(let error):
            loginButton.isHidden = false
            activityIndicator.isHidden = true
            errorMessageLabel.isHidden = false
            errorMessageLabel.stringValue = error
        }
    }
    
    func showAdminWindow() {
        performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "showAdminWindow"), sender: self)
        self.window?.close()
    }
    
    func validateTextFields() {
        let isInvalid = usernameTextField.stringValue.isEmpty || passwordTextField.stringValue.isEmpty
        loginButton.isEnabled = !isInvalid
    }
    
    enum State {
        case normal
        case authenticating
        case error(String)
    }
}

//MARK: - NSTextFieldDelegate
extension LoginViewController: NSTextFieldDelegate {
    
    override func controlTextDidChange(_ obj: Notification) {
        validateTextFields()
    }
    
}
