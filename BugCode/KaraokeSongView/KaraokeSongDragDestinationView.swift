//
//  KaraokeSongDragDestinationView.swift
//  Games Night macOS
//
//  Created by Mark Haskins on 08/02/2021.
//  Copyright © 2021 Mark Haskins. All rights reserved.
//

import Cocoa

protocol KaraokeSongDragDestinationViewDelegate: class {
    func fileDropped(filePath: URL)
}

final class KaraokeSongDragDestinationView: NSView {

    private var fileTypeIsOk = false
    private var acceptedFileExtensions = [ "zip", "cdg", "mp4" ]

    weak var delegate: KaraokeSongDragDestinationViewDelegate?

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        registerForDraggedTypes([.fileURL])
    }

    // MARK: - NSDraggingDestination
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        fileTypeIsOk = isExtensionAcceptable(draggingInfo: sender)
        return .generic
    }

    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return fileTypeIsOk ? .copy : []
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {

        guard !sender.filePathURLs.isEmpty else { return false }

        let filePathUrl = sender.filePathURLs.first!
        delegate?.fileDropped(filePath: filePathUrl)

        return true
    }

    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return true
    }

    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }

    func fileExtension(_ fileUrl: URL) -> String {
        return fileUrl.pathExtension.lowercased()
    }

    func isExtensionAcceptable(draggingInfo: NSDraggingInfo) -> Bool {

        guard !draggingInfo.filePathURLs.isEmpty else { return false }

        for filePathURL in draggingInfo.filePathURLs {

            let fileExt = fileExtension(filePathURL)

            if !acceptedFileExtensions.contains(fileExt) {
                return false
            }
        }

        return true
    }
}
