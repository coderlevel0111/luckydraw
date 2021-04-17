//
//  RoundViewController.swift
//  LuckyDraw
//

import UIKit

class RoundViewController: BasicViewController {
    private var stackView: UIStackView!
    private var prizeStackView: UIStackView!
    private var prizeNameLabel: UILabel!
    private var prizeCountLabel: UILabel!
    private var winnerStackView: UIStackView!
    private var buttonStacView: UIStackView!
    private var startButton: RoundButton!
    
    private let prize: Prize
    
    init(prize: Prize) {
        self.prize = prize
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupPlaceholderView()
    }

    private func setupStackView() {
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        setupPrizeView()
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
        prizeNameLabel.text = prize.name
        prizeNameLabel.textColor = UIColor.Customize.textBlack
        prizeNameLabel.font = UIFont.PingFangSC.bold(size: 48)
        prizeStackView.addArrangedSubview(prizeNameLabel)
        
        prizeCountLabel = UILabel()
        prizeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        prizeCountLabel.text = prize.countDescription
        prizeCountLabel.textColor = UIColor.Customize.textBlack
        prizeCountLabel.font = UIFont.PingFangSC.regular(size: 48)
        prizeStackView.addArrangedSubview(prizeCountLabel)
    }
    
    private func setupPlaceholderView() {
        let placeholderView = UIView()
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.setContentHuggingPriority(.defaultLow, for: .vertical)
        placeholderView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(placeholderView)
    }
}

extension RoundViewController {
    private func createWinnerLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.Customize.textBlack
        switch prize.count {
        case 1:
            label.font = UIFont.PingFangSC.regular(size: 48)
        case 1..<5:
            label.font = UIFont.PingFangSC.regular(size: 36)
        default:
            label.font = UIFont.PingFangSC.regular(size: 28)
        }
        return label
    }
}
