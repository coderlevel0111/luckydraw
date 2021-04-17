//
//  HomeViewController.swift
//  LuckyDraw
//

import UIKit

class HomeViewController: BasicViewController {
    
    private struct Const {
        static let buttonSize = CGSize(width: 266, height: 64)
    }
    
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    private var logoStackView: UIStackView!
    private var logoImageView: UIImageView!
    private var logoLabel: UILabel!
    private var buttonsStackView: UIStackView!
    
    private let party: Party
    
    init(party: Party) {
        self.party = party
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupLogoView()
        setupButtonsView(party.rounds)
        setupPlaceholderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupScrollView() {
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
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupLogoView() {
        logoStackView = UIStackView()
        logoStackView.translatesAutoresizingMaskIntoConstraints = false
        logoStackView.alignment = .center
        logoStackView.distribution = .fill
        logoStackView.axis = .vertical
        logoStackView.spacing = 18
        stackView.addArrangedSubview(logoStackView)
        
        logoImageView = UIImageView(image: UIImage(named: "icon_gift"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoStackView.addArrangedSubview(logoImageView)
        
        logoLabel = UILabel()
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.text = "Lucky Draw"
        logoLabel.textColor = UIColor.Customize.textOrange
        logoLabel.font = UIFont.PingFangSC.bold(size: 50)
        logoStackView.addArrangedSubview(logoLabel)
    }
    
    private func setupButtonsView(_ rounds: [Round]) {
        buttonsStackView = UIStackView()
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fill
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 60
        stackView.addArrangedSubview(buttonsStackView)
        stackView.setCustomSpacing(100, after: logoStackView)
        
        let column = 3
        let rows = rounds.count / column
        (0...rows).forEach { row in
            let containerView = UIStackView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.alignment = .fill
            containerView.distribution = .fillEqually
            containerView.axis = .horizontal
            containerView.spacing = 85
            buttonsStackView.addArrangedSubview(containerView)
            
            for i in (0...2) {
                let index = i + column * row
                if index >= rounds.count {
                    let placeholder = UIView()
                    placeholder.translatesAutoresizingMaskIntoConstraints = false
                    containerView.addArrangedSubview(placeholder)
                    placeholder.setContentHuggingPriority(.defaultLow, for: .horizontal)
                    placeholder.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                } else {
                    let round = rounds[index]
                    let button = RoundButton(type: .custom)
                    button.tag = index
                    button.setTitle(round.title, for: .normal)
                    button.setTitleColor(UIColor.Customize.textBlack, for: .normal)
                    button.setTitleColor(UIColor.white, for: .selected)
                    button.setTitleColor(UIColor.white, for: .highlighted)
                    button.titleLabel?.font = UIFont.PingFangSC.bold(size: 24)
                    button.configBackgroundImage(buttonHeight: Const.buttonSize.height,
                                                 cornerRadius: Const.buttonSize.height / 2)
                    button.addTarget(self, action: #selector(onRoundButtonClicked(_:)), for: .touchUpInside)
                    containerView.addArrangedSubview(button)
                    
                    NSLayoutConstraint.activate([
                        button.widthAnchor.constraint(equalToConstant: Const.buttonSize.width),
                        button.heightAnchor.constraint(equalToConstant: Const.buttonSize.height)
                    ])
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
}

extension HomeViewController {
    @objc private func onRoundButtonClicked(_ button: UIButton) {
        let round = party.rounds[button.tag]
        let vc = RoundContainerViewController(round: round)
        navigationController?.pushViewController(vc, animated: true)
    }
}
