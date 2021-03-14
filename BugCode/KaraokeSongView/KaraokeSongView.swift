//
//  SongView.swift
//  Games Night macOS
//
//  Created by Mark Haskins on 08/02/2021.
//  Copyright © 2021 Mark Haskins. All rights reserved.
//

import AVFoundation
import AVKit
import Cocoa
import SpriteKit

final class KaraokeSongView: NSView {

    @IBOutlet var rootView: NSView!

    @IBOutlet weak var songTitleView: NSTextField!
    @IBOutlet weak var currentTimeView: NSTextField!
    @IBOutlet weak var songLengthView: NSTextField!
    @IBOutlet weak var songPositionView: NSProgressIndicator!
    @IBOutlet weak var playPauseButton: NSButton!
    @IBOutlet weak var dragDestination: KaraokeSongDragDestinationView!
    @IBOutlet weak var unpackProgress: NSProgressIndicator!
    @IBOutlet weak var showInFinder: NSButton!

    @IBOutlet weak var songDisplayView: NSImageView!
    @IBOutlet weak var songVideoView: AVPlayerView!

    @IBOutlet weak var volumeSlider: NSSlider!

    var songUrl: URL!

    var player = AVAudioPlayer()
    var avPlayer = AVPlayer()

    let formatter = DateComponentsFormatter()

    var currentCdgPacket = 1.0

    var timer: Timer!


    required init?(coder: NSCoder) {

        super.init(coder: coder)

        let myName = type(of: self).className().components(separatedBy: ".").last!

        if let nib = NSNib(nibNamed: myName, bundle: Bundle(for: type(of: self))) {

            nib.instantiate(withOwner: self, topLevelObjects: nil)

            for newView in rootView.subviews {
                self.addSubview(newView)
            }

            setup()

        } else {
            print("init couldn't load nib")
        }
    }

    func setup() {

        playPauseButton.isEnabled = false

        formatter.allowedUnits = [.minute, .second ]
        formatter.zeroFormattingBehavior = [ .pad ]

        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(update),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc func update() {

    }

    @IBAction func playPauseAction(_ sender: Any) {
        changePlayState()
    }

    @IBAction func volumeChanged(_ sender: Any) {

    }

    @IBAction func openInFinder(_ sender: Any) {
        NSWorkspace.shared.activateFileViewerSelecting([songUrl])
    }

    func changePlayState() {

    }

    fileprivate func reset() {
        songDisplayView.isHidden = true
        songDisplayView.image = nil

        showInFinder.isHidden = true

        songVideoView.isHidden = true

        playPauseButton.isEnabled = false

        songTitleView.stringValue = "--"
        currentTimeView.stringValue = "00:00"
        songLengthView.stringValue = "00:00"

        songPositionView.minValue = 0
        songPositionView.maxValue = 100
        songPositionView.doubleValue = 0

        player = AVAudioPlayer()
        avPlayer = AVPlayer()
    }
}
