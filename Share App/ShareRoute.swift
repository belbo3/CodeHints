//
//  ShareRoute.swift
//  VoiceTranslator-UI
//
//  Created by Oleksandr Vynnyk on 01.12.2022.
//

import UIKit

public protocol ShareRoute where Self: RouterProtocol {
  func openShare(_ texts: [String], completion: Transition.Completion?)
}

public extension ShareRoute {
  func openShare(_ texts: [String], completion: Transition.Completion?) {
		let textShare = texts
		let appLink = URL(string: "https://apps.apple.com/app/id1661768151")!
		let textToShare: [Any] = [
			MyActivityItemSource(title: "Voice Translator: Camera, Text", text: textShare.joined(separator: "\n"), link: appLink)
		]
		let activityViewController = UIActivityViewController(activityItems: textToShare , applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = viewController?.view
		let transition = ModalTransition(fromViewController: viewController)
		transition.open(activityViewController, animated: true, completion: completion)
  }
}
