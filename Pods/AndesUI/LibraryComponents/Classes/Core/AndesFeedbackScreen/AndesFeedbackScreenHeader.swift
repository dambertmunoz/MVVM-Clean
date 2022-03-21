//
//  AndesFeedbackScreenHeader.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 12/08/2021.
//

import UIKit

@objc
public class AndesFeedbackScreenHeader: NSObject {
    private(set) var feedbackText: AndesFeedbackScreenText
    private(set) var thumbnail: AndesFeedbackScreenThumbnail?
    var thumbnailView: AndesThumbnailBadge?

    @objc public init(feedbackText: AndesFeedbackScreenText, thumbnailInfo: AndesFeedbackScreenThumbnail) {
        self.feedbackText = feedbackText
        self.thumbnail = thumbnailInfo
    }
}
