//
//  NSDraggingInfo.swift
//  BugCode
//
//  Created by Mark Haskins on 14/03/2021.
//

import Cocoa

extension NSDraggingInfo {

    var filePathURLs: [URL] {

        var urls = [URL]()

        if let filenames = draggingPasteboard.propertyList(
            forType: NSPasteboard.PasteboardType("NSFilenamesPboardType")) as? [String] {

            for filename in filenames {
                urls.append(URL(fileURLWithPath: filename))
            }
        }

        return urls
    }
}
