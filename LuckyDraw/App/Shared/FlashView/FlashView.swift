//
//  FlashView.swift
//  LuckyDraw
//

import UIKit


protocol FlashViewDataSource: class {
    func numberOfLabels() -> Int
    func stringsForFlash() -> [String]
}

class FlashView: UIView {
    private var stackView: UIStackView!
    private var displayLink: CADisplayLink!
    private weak var dataSource: FlashViewDataSource? = nil
    
    private let numberOfLabels: Int
    private var startIndex: Int = 0

    init(dataSource: FlashViewDataSource) {
        self.dataSource = dataSource
        self.numberOfLabels = dataSource.numberOfLabels()
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit FLASH VIEW")
    }
    
    func startFlashLabels() {
        setupDisplayLink()
        displayLink.add(to: .main, forMode: .default)
    }
    
    func stopFlashLabels() {
        displayLink.remove(from: .main, forMode: .default)
        displayLink.invalidate()
        startIndex = 0
        displayLink = nil
        
    }
    
    func updateResult(_ results: [String]) {
        zip(results, findAllLabels()).forEach { $0.1.text = $0.0 }
    }
    
    func clearView() {
        findAllLabels().forEach { $0.text = nil }
    }
}

extension FlashView {
    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(onLabelChanged))
        displayLink.preferredFramesPerSecond = 30
    }
    
    @objc private func onLabelChanged() {
        guard let labelResources = dataSource?.stringsForFlash().shuffled() else {
            stopFlashLabels()
            return
        }
        
        var pendingLabels: [String] = []
        (0..<numberOfLabels).forEach { index in
            startIndex += 1
            if startIndex >= labelResources.count {
                startIndex = 0
            }
            pendingLabels.append(labelResources[startIndex])
        }
        updateResult(pendingLabels)
    }
}

extension FlashView {
    
    private func findAllLabels() -> [UILabel] {
        let labels = stackView.arrangedSubviews.compactMap { $0 as? UIStackView }
            .flatMap { $0.arrangedSubviews.compactMap{ $0 as? UILabel } }
        return labels
    }
    
    private func setupView() {
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 80
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        setupPlaceholderView()
        setupLabels()
        setupPlaceholderView()
    }
    
    private func setupLabels() {
        let maxRow = 5
        let labelCounts = numberOfLabels
        let columns = (labelCounts > maxRow) ? 2 : 1
        
        (0..<columns).forEach { column in
            var rows = labelCounts - column * maxRow
            if rows > 5 {
                rows = 5
            } else if rows < 0 {
                rows = 0
            }
            
            let labelStackView = UIStackView()
            labelStackView.translatesAutoresizingMaskIntoConstraints = false
            labelStackView.alignment = columns > 1 ? .leading : .center
            labelStackView.distribution = .fillEqually
            labelStackView.axis = .vertical
            labelStackView.spacing = 20
            stackView.addArrangedSubview(labelStackView)
            
            (0..<rows).forEach {_ in
                let label = createLabel()
                labelStackView.addArrangedSubview(label)
            }
            
            if columns > 1 {
                (0..<(maxRow - rows)).forEach {_ in
                    let placeholderView = UIView()
                    placeholderView.translatesAutoresizingMaskIntoConstraints = false
                    placeholderView.setContentHuggingPriority(.defaultLow, for: .vertical)
                    placeholderView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
                    labelStackView.addArrangedSubview(placeholderView)
                }
            }
        }
    }
    
    private func setupPlaceholderView() {
        let placeholderView = UIView()
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.setContentHuggingPriority(.defaultLow, for: .vertical)
        placeholderView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(placeholderView)
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.Customize.textBlack
        switch numberOfLabels {
        case 1:
            label.font = UIFont.PingFangSC.regular(size: 48)
        case 1...5:
            label.font = UIFont.PingFangSC.regular(size: 36)
        default:
            label.font = UIFont.PingFangSC.regular(size: 28)
        }
        return label
    }
}
