//
//  MyActivityItemSource.swift
//  VoiceTranslator-UI
//
//  Created by Oleksandr Vynnyk on 23.08.2022.
//

import LinkPresentation

final class MyActivityItemSource: NSObject, UIActivityItemSource {
	var title: String
	var text: String
	var link: URL
		
	init(title: String, text: String, link: URL) {
		self.title = title
		self.text = text
		self.link = link
		super.init()
	}
	
	func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
		return text == "" ? link.absoluteString : text + "\n" + link.absoluteString
	}
	
	func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
		return text == "" ? link.absoluteString : text + "\n" + link.absoluteString
	}
	
	func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
		return text == "" ? link.absoluteString : text + "\n" + link.absoluteString
	}

	func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
		let metadata = LPLinkMetadata()
		metadata.title = title
		metadata.iconProvider = NSItemProvider(object: UIImage.imageLogoWithCorners)
		metadata.originalURL = link
		metadata.url = link
		return metadata
	}
}
