//
//  RoundContainerViewController.swift
//  LuckyDraw
//

import UIKit

class RoundContainerViewController: UIPageViewController {

    let round: Round
    weak var luckyDrawDelegate: LuckyDrawDelegate? = nil
    private var currentIndex: Int = 0
    
    private lazy var roundVCs = {
        round.sessions.map { item -> RoundViewController in
            let vc = RoundViewController(session: item)
            vc.luckyDrawDelegate = luckyDrawDelegate
            return vc
        }
    }()
    
    init(round: Round) {
        self.round = round
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = round.title
        view.backgroundColor = UIColor.Customize.viewBackground
        if let firstVC = roundVCs.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        setupPageIndicator()
        dataSource = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension RoundContainerViewController {
    private func setupPageIndicator() {
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.pageIndicatorTintColor = UIColor.lightGray
        appearance.currentPageIndicatorTintColor = .white
    }
}

extension RoundContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? RoundViewController,
              let vcIndex = roundVCs.firstIndex(of: vc) else { return nil }
        
        let previousIndex = vcIndex - 1
        currentIndex = vcIndex
        guard previousIndex >= 0,
              roundVCs.count > previousIndex else { return nil }
        return roundVCs[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? RoundViewController,
              let vcIndex = roundVCs.firstIndex(of: vc) else { return nil }
        
        let previousIndex = vcIndex + 1
        currentIndex = vcIndex
        guard previousIndex >= 0,
              roundVCs.count > previousIndex else { return nil }
        return roundVCs[previousIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return roundVCs.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}
