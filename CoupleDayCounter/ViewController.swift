//
//  ViewController.swift
//  CoupleDayCounter

import UIKit
import AVFoundation

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var ddayLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var startDate: Date?
    var selectedDate: Date?
    var audioPlayer: AVAudioPlayer?
    var currentBgmIndex: Int?
    let bgmList = ["song1", "song2", "song3", "song4", "song5"]
    var dimmedBackgroundView: UIView?
    var containerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 배경 이미지 설정
        imageView.image = UIImage(named: "couple")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        ddayLabel.layer.cornerRadius = 10
        ddayLabel.clipsToBounds = true

        startButton.layer.cornerRadius = 10
        playButton.layer.cornerRadius = 10
        stopButton.layer.cornerRadius = 10
        nextButton.layer.cornerRadius = 10
                
        // D-Day 초기값 설정
        ddayLabel.text = "0"
    }
    
    
    @IBAction func tapStartDate(_ sender: UIButton) {
        // Dimmed background
        let dimmedView = UIView(frame: self.view.bounds)
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        dimmedView.tag = 999
        self.view.addSubview(dimmedView)
        self.dimmedBackgroundView = dimmedView
                
        // Container view
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        dimmedView.addSubview(container)
        self.containerView = container
                
        // DatePicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(datePicker)
                
        // Confirm button
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(confirmButton)
                
        // AutoLayout
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: dimmedView.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: dimmedView.centerYAnchor),
            container.widthAnchor.constraint(equalTo: dimmedView.widthAnchor, multiplier: 0.85),
            container.heightAnchor.constraint(equalToConstant: 400),
                    
            datePicker.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            datePicker.heightAnchor.constraint(equalToConstant: 300),
                    
            confirmButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            confirmButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 44)
        ])
                
        confirmButton.addAction(UIAction { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.startDate = datePicker.date
                self.updateDdayLabel()
                self.dimmedBackgroundView?.removeFromSuperview()
                self.selectedDate = nil
            }
        }, for: .touchUpInside)
                
        // 배경 클릭 시 닫기
        let tapOutside = UITapGestureRecognizer(target: self, action: #selector(removeDatePickerView))
        tapOutside.delegate = self
        dimmedView.addGestureRecognizer(tapOutside)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    @objc func removeDatePickerView() {
        dimmedBackgroundView?.removeFromSuperview()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            if let view = touch.view, let container = containerView {
                return !view.isDescendant(of: container)
            }
            return true
    }

    
    // MARK: - D-Day 계산 및 업데이트
    func updateDdayLabel() {
        guard let start = startDate else { return }
        let today = Date()
        let diff = Calendar.current.dateComponents([.day], from: start, to: today).day ?? 0
        let dday = diff + 1
        ddayLabel.text = "\(dday)"
    }
    
    
    @IBAction func tapPlay(_ sender: UIButton) {
        if let player = audioPlayer {
            if player.isPlaying {
                // 🎯 이미 재생 중이면 아무 일도 하지 않음
                return
            } else {
                // 일시정지된 상태면 다시 재생
                player.play()
            }
        } else {
            // 최초 재생
            playRandomBgm()
        }
    }
    
    @IBAction func tapStop(_ sender: UIButton) {
        audioPlayer?.pause()
    }
    
    @IBAction func tapNext(_ sender: UIButton) {
        playNextBgm()
    }
    
    
    
    // MARK: - 랜덤 음악 재생
    func playRandomBgm() {
        currentBgmIndex = Int.random(in: 0..<bgmList.count)
        playBgm(at: currentBgmIndex!)
    }
        
    // MARK: - 다음 음악 재생
    func playNextBgm() {
        guard let current = currentBgmIndex else {
            playRandomBgm(); return
        }
        var next = Int.random(in: 0..<bgmList.count)
        while next == current {
            next = Int.random(in: 0..<bgmList.count)
        }
        currentBgmIndex = next
        playBgm(at: next)
    }
        
    // MARK: - 음악 파일 재생
    func playBgm(at index: Int) {
        let name = bgmList[index]
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("BGM 재생 오류:", error.localizedDescription)
            }
        }
    }


}

