//
//  OnboardingContainerViewController.swift
//  Diamond_Bank
//
//  Created by Sailau Almaz Maratuly on 25.11.2022.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {

    private let pageViewController: UIPageViewController
    
    private var pages = [UIViewController]()
    
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    private var currentVC: UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else { return }
            nextButton.isHidden = index == pages.count - 1 // hide if on last page
            backButton.isHidden = index == 0
            doneButton.isHidden = !(index == pages.count - 1 ) //show if on last page
        }
    }

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: [])
        button.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        return button
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: [])
        button.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
        return button
    }()
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: [])
        button.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: [])
        button.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(animationName: "onboarding-page1", titleText: "New banking", descriptionTitleText: "Free advisory service, mobile banking application.")
        let page2 = OnboardingViewController(animationName: "onboarding-page2", titleText: "Zero fees", descriptionTitleText: "Bank your life. We create something new you have never seen before.")
        let page3 = OnboardingViewController(animationName: "onboarding-page3", titleText: "Make it simple", descriptionTitleText: "We pay attention to all your payments, and find way for saving your money.")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        addSubviews()
        addConstraints()
        
    }
    
    
    
}

// MARK: Add subviews, constraints and setup
extension OnboardingContainerViewController {
    
    func setup() {
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
        
        //Page control color
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.systemGray6
        pageControl.currentPageIndicatorTintColor = UIColor.systemGray
    }
    
    func addSubviews() {
        //PageViewController
        addChild(pageViewController)
        
        view.addSubview(pageViewController.view)
        view.addSubview(nextButton)
        view.addSubview(backButton)
        view.addSubview(doneButton)
        view.addSubview(closeButton)

        pageViewController.didMove(toParent: self)
        
    }
    
    func addConstraints() {
        //PageViewController
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        //NextButton
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 4)
        ])
        
        //BackButton
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 4)
        ])
        
        //DoneButton
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 4)
        ])
        
        
        //CloseButton
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])

    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

// MARK: Actions
extension OnboardingContainerViewController {
    
    @objc func nextTapped(_ sender: UIButton) {
        guard let nextVC = getNextViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func backTapped(_ sender: UIButton) {
        guard let previousVC = getPreviousViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true, completion: nil)
    }
    
    @objc func doneTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
    @objc func closeTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
}
