//
//  ContactUS.swift
//  PushTest
//
//  Created by Oleksandr Yakobshe on 29.01.2023.
//

import UIKit
import MessageUI

final class CustomViewController: UIViewController, MFMailComposeViewControllerDelegate {
	
	func toMail(_ email: String) {
		if MFMailComposeViewController.canSendMail() {
			let mail = MFMailComposeViewController()
			mail.mailComposeDelegate = self
			mail.setToRecipients([email])
			mail.setSubject("")
			mail.setMessageBody("", isHTML: false)
			present(mail, animated: true)
		} else {
			if let url = URL(string: "mailto:\(email)") {
				UIApplication.shared.open(url)
			}
		}
	}
	
	// MARK: - MFMailComposeViewControllerDelegate
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true)
	}
}
