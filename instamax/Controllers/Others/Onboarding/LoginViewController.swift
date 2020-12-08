//
//  LoginViewController.swift
//  instamax
//
//  Created by Fernando on 15-11-20.
//
import SafariServices
import UIKit

class LoginViewController: UIViewController {
	
	struct Constants {
		static let cornerRadius: CGFloat = 8.0
	}
	
	private let usernameEmailField: UITextField = {
		let field = UITextField()
		field.placeholder =  "usuario o contraseña..."
		field.returnKeyType = .next
		field.leftViewMode = .always
		field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
		field.autocapitalizationType = .none
		field.autocorrectionType = .no
		field.layer.masksToBounds = true
		field.layer.cornerRadius = Constants.cornerRadius
		field.backgroundColor = .secondarySystemBackground
		field.layer.borderWidth = 1.0
		field.layer.borderColor = UIColor.secondaryLabel.cgColor
		return field
	}()
	
	private let passwordField: UITextField = {
		let field = UITextField()
		field.isSecureTextEntry = true
		field.placeholder =  "password..."
		field.returnKeyType = .continue
		field.leftViewMode = .always
		field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
		field.autocapitalizationType = .none
		field.autocorrectionType = .no
		field.layer.masksToBounds = true
		field.layer.cornerRadius = Constants.cornerRadius
		field.backgroundColor = .secondarySystemBackground
		field.layer.borderWidth = 1.0
		field.layer.borderColor = UIColor.secondaryLabel.cgColor
		return field
	}()

	private let loginButton: UIButton = {
		let button = UIButton()
		button.setTitle("Ingresar", for: .normal)
		button.layer.masksToBounds =  true
		button.layer.cornerRadius =  Constants.cornerRadius
		button.backgroundColor = .systemBlue
		button.setTitleColor(.white, for: .normal)
		return button
	}()
	
	private let termsButton: UIButton = {
		let button =  UIButton()
		button.setTitle("Términos y condiciones", for: .normal)
		button.setTitleColor(.secondaryLabel, for: .normal)
		return button
	}()
	
	private let createAccountButton: UIButton = {
		let button = UIButton()
		button.setTitleColor(.label, for: .normal)
		button.setTitle("crea una cuenta", for: .normal)
		return button
	}()
	
	private let privacyButton: UIButton = {
		let button =  UIButton()
		button.setTitle("Políticas de privacidad", for: .normal)
		button.setTitleColor(.secondaryLabel, for: .normal)
		return button
	}()
	
	private let headerView: UIView = {
		let header = UIView()
		header.clipsToBounds = true
		let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
		header.addSubview(backgroundImageView)
		return header
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
		createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
		termsButton.addTarget(self, action: #selector(didTapTermButton), for: .touchUpInside)
		privacyButton.addTarget(self, action: #selector(didTapPrivacynButton), for: .touchUpInside)
		
		usernameEmailField.delegate = self
		passwordField.delegate = self
		addSubViews()
		view.backgroundColor = .systemBackground

    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		//assing frames
		headerView.frame = CGRect(
			x: 0,
			y: 0.0,
			width: view.width,
			height: view.height/3.0
		)
		
		usernameEmailField.frame = CGRect(
			x: 25,
			y: headerView.bottom + 40,
			width: view.width-50,
			height: 52
		)
		
		passwordField.frame = CGRect(
			x: 25,
			y: usernameEmailField.bottom + 10,
			width: view.width-50,
			height: 52
		)
		
		loginButton.frame = CGRect(
			x: 25,
			y: passwordField.bottom + 10,
			width: view.width-50,
			height: 52
		)
		
		createAccountButton.frame = CGRect(
			x: 25,
			y: loginButton.bottom + 10,
			width: view.width-50,
			height: 52
		)
		
		termsButton.frame = CGRect(
			x: 10,
			y: view.height - view.safeAreaInsets.bottom-100,
			width: view.width-20,
			height: 50
		)
		
		privacyButton.frame = CGRect(
			x: 10,
			y: view.height - view.safeAreaInsets.bottom-50,
			width: view.width-20,
			height: 50
		)
		
		configureHeaderView()
	}
	
	private func configureHeaderView() {
		guard headerView.subviews.count == 1 else {
			return
		}
		
		guard let backgroundView = headerView.subviews.first else {
			return
		}
		backgroundView.frame = headerView.bounds
		let imageView = UIImageView(image: UIImage(named: "text"))
		headerView.addSubview(imageView)
		imageView.contentMode = .scaleAspectFit
		imageView.frame = CGRect(
			x: headerView.width/4.0,
			y: view.safeAreaInsets.top,
			width: headerView.width / 2.0,
			height: headerView.height - view.safeAreaInsets.top)
		
//		add instagram logo
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
    
	@objc private func didTapLoginButton() {
		passwordField.resignFirstResponder()
		usernameEmailField.resignFirstResponder()
		
		guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
			  let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
			return
		}
		// login funcion
		// new vars for login logic
		var username : String?
		var email: String?
		
		if usernameEmail.contains("@"), usernameEmail.contains("."){
			//email
			print("es un correo")
			email =  usernameEmail
		}
		else{
			//username
			username = usernameEmail
			print("es un nombre de usuario")
		}
		
		AuthManager.shared.loginUser(username: username, email: email, password: password) { succes in
			//add GCP
			
			DispatchQueue.main.async {
				if succes {
					self.dismiss(animated: true, completion: nil)
				}
				else {
					//error
					let alert = UIAlertController(title: "Log in Error", message: "no se ha posido iniciar sesión", preferredStyle: .alert)
					
					alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
					
					self.present(alert, animated: true)
				}
			}
		}
	}
	@objc private func didTapTermButton() {
		guard let url = URL(string: "https://www.instagram.com/terms/accept/?hl=es") else {
			return
		}
		let vc = SFSafariViewController(url: url)
		present(vc, animated: true)
	}
	@objc private func didTapPrivacynButton() {
		guard let url = URL(string: "https://www.instagram.com/terms/accept/?hl=es") else {
			return
		}
		let vc = SFSafariViewController(url: url)
		present(vc, animated: true)
	}
	@objc private func didTapCreateAccountButton() {
		let vc  = RegistrationViewController()
		present(vc, animated: true) {
			
		}
	}


}

extension LoginViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == usernameEmailField{
			passwordField.becomeFirstResponder()
		}
		else if textField == passwordField{
			didTapLoginButton()
		}
		return true
	}
}
