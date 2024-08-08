//
//  AudioPlayerView.swift
//  testAppSwift
//
//  Created by Salman Afzal on 06/08/2024.
//
import UIKit
import AVFoundation

@IBDesignable
class AudioPlayerView: UIView {

    // MARK: - Properties

    private let toggleButton = UIButton()
    private let trackNameLabel = UILabel()

     var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var isPlaying = false

    // MARK: - Inspectable Properties
    
    @IBInspectable
       var color: UIColor? {
           didSet {
               self.backgroundColor = color
           }
       }
       

    @IBInspectable var playButtonTitle: String = "Play" {
        didSet {
            updateButtonTitle()
        }
    }

    @IBInspectable var pauseButtonTitle: String = "Pause" {
        didSet {
            updateButtonTitle()
        }
    }

    @IBInspectable var trackName: String = "Track Name" {
        didSet {
            trackNameLabel.text = trackName
        }
    }

    @IBInspectable var audioURL: String? {
        didSet {
            if let urlString = audioURL, let url = URL(string: urlString) {
                setupPlayer(with: url)
            }
        }
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        // Configure Toggle Button
        toggleButton.setTitle(playButtonTitle, for: .normal)
        toggleButton.setTitleColor(.blue, for: .normal)
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        addSubview(toggleButton)

        // Configure Track Name Label
        trackNameLabel.text = trackName
        trackNameLabel.textAlignment = .center
        trackNameLabel.textColor = .black
        addSubview(trackNameLabel)
    }

    private func setupConstraints() {
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Track Name Label Constraints
            trackNameLabel.topAnchor.constraint(equalTo: topAnchor),
            trackNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            trackNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackNameLabel.heightAnchor.constraint(equalToConstant: 30),

            // Toggle Button Constraints
            toggleButton.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 10),
            toggleButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // MARK: - Player Setup

    private func setupPlayer(with url: URL) {
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        // Add observer to update play/pause state
        playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new, .old], context: nil)
        // Update button state when player changes status
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: .main, using: { [weak self] _ in
            self?.updateButtonState()
        })
    }

    // MARK: - Actions

    @objc private func toggleButtonTapped() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
        updateButtonTitle()
    }

    private func updateButtonTitle() {
        let title = isPlaying ? pauseButtonTitle : playButtonTitle
        toggleButton.setTitle(title, for: .normal)
    }

    private func updateButtonState() {
        if player?.rate == 0 {
            // Paused or stopped
            isPlaying = false
        } else {
            // Playing
            isPlaying = true
        }
        updateButtonTitle()
    }

    // MARK: - Observe Player Item

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            updateButtonState()
        }
    }
    
    deinit {
          // Remove observer to prevent memory leaks
          playerItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
      }
    
    
}
