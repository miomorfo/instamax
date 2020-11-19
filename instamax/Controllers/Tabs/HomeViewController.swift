//
//  ViewController.swift
//  instamax
//
//  Created by Fernando on 15-11-20.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		handleNotAuth()

	}
	
	private func handleNotAuth(){
		//		verificar el estatus:
		if Auth.auth().currentUser == nil {
			let loginVC = LoginViewController()
			loginVC.modalPresentationStyle = .fullScreen
			present(loginVC, animated: true)
		}
	}


}

