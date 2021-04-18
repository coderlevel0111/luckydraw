//
//  RoundViewController.swift
//  LuckyDraw
//

import UIKit

class RoundViewController: BasicViewController {
    private struct Const {
        static let goTitle: String = "GO!"
        static let stopTitle: String = "STOP"
        static let drawButtonSize: CGSize = CGSize(width: 266, height: 64)
        static let clearButtonSize: CGSize = CGSize(width: 120, height: 44)
    }
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    private var prizeStackView: UIStackView!
    private var prizeNameLabel: UILabel!
    private var prizeCountLabel: UILabel!
    private var winnerView: FlashView!
    private var buttonView: UIView!
    private var drawButton: RoundButton!
    private var clearButton: UIButton!
    
    private let session: RoundSession
    private var isDrawing: Bool = false
    
    weak var luckyDrawDelegate: LuckyDrawDelegate? = nil
    
    init(session: RoundSession) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupButtonView()
        updateView()
    }
    
    deinit {
        print("RoundViewVC deinit")
    }
    
    private func updateDrawButton() {
        if isDrawing {
            drawButton.setTitle(Const.stopTitle, for: .normal)
        } else {
            drawButton.setTitle(Const.goTitle, for: .normal)
        }
    }
    
    private func updateView() {
        if session.winners.count > 0 {
            winnerView.updateResult(session.winners.map { "\($0)" })
            drawButton.setTitle(Const.stopTitle, for: .normal)
            drawButton.isEnabled = false
        }
    }
    
    @objc private func didDrawButtonClicked() {
        if isDrawing {
            isDrawing = !isDrawing
            winnerView.stopFlashLabels()
            drawButton.isEnabled = false
            updateWinners()
        } else {
            isDrawing = !isDrawing
            winnerView.startFlashLabels()
            updateDrawButton()
        }
        
        clearButton.isEnabled = !isDrawing
    }
    
    @objc private func didClearButtonClicked() {
        isDrawing = false
        updateDrawButton()
        winnerView.clearView()
        session.clearWinners()
        drawButton.isEnabled = true
    }
    
    private func updateWinners() {
        guard let winners = luckyDrawDelegate?.getRandomWinners(with: session.prize.count) else {
            winnerView.clearView()
            session.clearWinners()
            return
        }
        session.updateWinners(winners)
        winnerView.updateResult(winners.map { "\($0)" })
    }
}

extension RoundViewController {
    private func setupStackView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 80, leading: 0, bottom: 20, trailing: 0)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        setupPrizeView()
        setupWinnerView()
    }
    
    private func setupPrizeView() {
        prizeStackView = UIStackView()
        prizeStackView.translatesAutoresizingMaskIntoConstraints = false
        prizeStackView.alignment = .center
        prizeStackView.distribution = .fill
        prizeStackView.axis = .vertical
        prizeStackView.spacing = 12
        stackView.addArrangedSubview(prizeStackView)
        
        prizeNameLabel = UILabel()
        prizeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        prizeNameLabel.text = session.prize.name
        prizeNameLabel.textColor = UIColor.Customize.textBlack
        prizeNameLabel.font = UIFont.PingFangSC.bold(size: 48)
        prizeStackView.addArrangedSubview(prizeNameLabel)
        
        prizeCountLabel = UILabel()
        prizeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        prizeCountLabel.text = session.prize.countDescription
        prizeCountLabel.textColor = UIColor.Customize.textBlack
        prizeCountLabel.font = UIFont.PingFangSC.regular(size: 48)
        prizeStackView.addArrangedSubview(prizeCountLabel)
    }
    
    private func setupWinnerView() {
        winnerView = FlashView(dataSource: self)
        stackView.addArrangedSubview(winnerView)
    }
    
    private func setupPlaceholderView() {
        let placeholderView = UIView()
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.setContentHuggingPriority(.defaultLow, for: .vertical)
        placeholderView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(placeholderView)
    }
    
    private func setupButtonView() {
        buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(buttonView)
        
        drawButton = RoundButton(type: .custom)
        drawButton.translatesAutoresizingMaskIntoConstraints = false
        drawButton.setTitleColor(.white, for: .normal)
        drawButton.setTitleColor(.white, for: .selected)
        drawButton.setTitleColor(.white, for: .highlighted)
        drawButton.titleLabel?.font = UIFont.PingFangSC.bold(size: 24)
        drawButton.configBackgroundImage(normalColor: UIColor.Customize.roundButtonSelected,
                                         selectedColor: UIColor.Customize.stopButtonSelected,
                                         buttonHeight: Const.drawButtonSize.height,
                                         cornerRadius: Const.drawButtonSize.height / 2.0)
        drawButton.addTarget(self, action: #selector(didDrawButtonClicked), for: .touchUpInside)
        updateDrawButton()
        buttonView.addSubview(drawButton)
        
        clearButton = UIButton(type: .custom)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("Clear", for: .normal)
        clearButton.setTitleColor(UIColor.Customize.textBlack, for: .normal)
        clearButton.setTitleColor(UIColor.Customize.textBlack, for: .selected)
        clearButton.setTitleColor(UIColor.Customize.textBlack, for: .highlighted)
        clearButton.titleLabel?.font = UIFont.PingFangSC.regular(size: 24)
        clearButton.layer.cornerRadius = Const.clearButtonSize.height / 2.0
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.Customize.textBlack.cgColor
        clearButton.addTarget(self, action: #selector(didClearButtonClicked), for: .touchUpInside)
        buttonView.addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            drawButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 10),
            drawButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -10),
            drawButton.widthAnchor.constraint(equalToConstant: Const.drawButtonSize.width),
            drawButton.heightAnchor.constraint(equalToConstant: Const.drawButtonSize.height),
            drawButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            drawButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            
            clearButton.leadingAnchor.constraint(greaterThanOrEqualTo: buttonView.leadingAnchor, constant: 10),
            clearButton.trailingAnchor.constraint(equalTo: drawButton.leadingAnchor, constant: -150),
            clearButton.centerYAnchor.constraint(equalTo: drawButton.centerYAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: Const.clearButtonSize.width),
            clearButton.heightAnchor.constraint(equalToConstant: Const.clearButtonSize.height),
        ])
    }
}

extension RoundViewController: FlashViewDataSource {
    func numberOfLabels() -> Int {
        return session.prize.count
    }
    
    func stringsForFlash() -> [String] {
        guard let delegate = luckyDrawDelegate else { return [] }
        return delegate.fetchCurrentAttendees().map { "\($0)" }
    }
}
