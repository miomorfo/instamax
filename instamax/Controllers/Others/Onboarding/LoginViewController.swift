//
//  LoginViewController.swift
//  instamax
//
//  Created by Fernando on 15-11-20.
//

import UIKit

class LoginViewController: UIViewController {
	
	
	private let usernameEmailField: UITextField = {
		return UITextField()
	}()
	
	private let passwordField: UITextField = {
		let field = UITextField()
		field.isSecureTextEntry = true
		return field
	}()

	private let loginButton: UIButton = {
		return UIButton()
	}()
	
	private let termsButton: UIButton = {
		return UIButton()
	}()
	
	private let createAccountButton: UIButton = {
		return UIButton()
	}()
	
	private let privacyButton: UIButton = {
		return UIButton()
	}()
	
	private let headerView: UIView = {
		return UIView()
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		addSubViews()
		view.backgroundColor = .systemBackground

    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		//assing frames
	}
	
	private func addSubViews() {
		view.addSubview(usernameEmailField)
		view.addSubview(passwordField)
		view.addSubview(loginButton)
		view.addSubview(termsButton)
		view.addSubview(privacyButton)
		view.addSubview(createAccountButton)
		view.addSubview(headerView)
		
	}
    
	@objc private func didTapLoginButton() {}
	@objc private func didTapTermButton() {}
	@objc private func didTapPrivacynButton() {}
	@objc private func didTapCreateAccountButton() {}


}
