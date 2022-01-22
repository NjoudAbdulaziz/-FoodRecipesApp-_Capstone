//
//  MainVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 24/05/1443 AH.
//

import UIKit

class MainVC: UIViewController {

    private var sideMeneuVC:SideMenuVC!
    private var sideMenuShadowView:UIView!
    private var sideMenuRevealWidth: CGFloat = 260
 
    //The paddingForRotation variable is used to “push” the side menu more to the left when it’s closed because, during the rotation, it shows up a little bit.
    
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation:CGFloat = 0.0
    
    //Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    
    var gestrueEnabled:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start observing style change
        startObserving(&UserInterfaceStyleManager.shared)
        
        // Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TabGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop{
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        // Side Menu
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.sideMeneuVC = storyboard.instantiateViewController(withIdentifier: "SideMenuID") as? SideMenuVC
        
        self.sideMeneuVC.defaultHighlightedCell = 0 // Default Highlighted Cell
        self.sideMeneuVC.delegate = self
        view.insertSubview(self.sideMeneuVC!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMeneuVC!)
        self.sideMeneuVC!.didMove(toParent: self)
        
        //Side Menu AutoLayout
        self.sideMeneuVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop{
            self.sideMenuTrailingConstraint = self.sideMeneuVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMeneuVC.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
            self.sideMeneuVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMeneuVC.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        // Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlepanGesture))
        panGestureRecognizer.delegate = self
        panGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(panGestureRecognizer)
        
        // Default Main View Controller
        showViewController(viewController: UINavigationController.self , storyboardId: "SearchNavID")
    }
    

    //  Keep the state of the side menu (expanded or collapse) in rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if self.revealSideMenuOnTop{
                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 :(-self.sideMenuRevealWidth - self.paddingForRotation)
            }
            
        }
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            // When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    //Call this Button Action from the View Controller that I want to Expand/Collapse when tap a button
    @IBAction open func revealSideMenu() {
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    func sideMenuState(expanded:Bool) {
        if expanded{
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0}
        }
        else{
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) :0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0}
        }
    }
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool)->()){
        UIView.animate(withDuration: 0.5,delay: 0, usingSpringWithDamping: 1.0 , initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else{
                self.view.subviews[1].frame.origin.x = targetPosition
            }
            
        }, completion: completion)
    }
    override var  preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
//extend the MainVC and add the SideMenuVCDelegate and implement the methods
extension MainVC : SideMenuVCDelegate {
    
    func selectedCell(_ row: Int) {
        switch row {
        case 0:
            //Search page
            self.showViewController(viewController: UINavigationController.self , storyboardId: "SearchNavID")
        case 1:
            //Saved page
            self.showViewController(viewController: UINavigationController.self , storyboardId: "SavedNavID")
        case 2:
            //Settings page
            self.showViewController(viewController: UINavigationController.self , storyboardId: "SettingsNavID")
        case 3:
            //About us page
            self.showViewController(viewController: UINavigationController.self , storyboardId: "AboutUsVCNavID")
            
            
        default:
            break
        }
        
        // Collapse side menu with animation
        DispatchQueue.main.async {self.sideMenuState(expanded: false) }
    }
    
    func showViewController<T:UIViewController>(viewController: T.Type , storyboardId : String ) ->() {
        // Remove the previous View
        for subview in view.subviews {
            if subview.tag == 99 {
                subview.removeFromSuperview()
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        vc.view.tag = 99
        view.insertSubview(vc.view, at: self.revealSideMenuOnTop ? 0 : 1)
        addChild(vc)
        
        if !self.revealSideMenuOnTop {
            if isExpanded{
                vc.view.frame.origin.x = self.sideMenuRevealWidth
            }
            if self.sideMenuShadowView != nil{
                vc.view.addSubview(self.sideMenuShadowView)
            }
        }
        vc.didMove(toParent: self)
    }
    
}

extension MainVC : UIGestureRecognizerDelegate {
    @objc func TabGestureRecognizer(sender: UITapGestureRecognizer){
        if sender .state == .ended {
            if self.isExpanded{
                self.sideMenuState(expanded: false)
            }
        }
    }
    // Close side menu when tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer:UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool{
        if (touch.view?.isDescendant(of: self.sideMeneuVC.view))! {
            return false
        }
        return true
    }
    
    // Dragging Side Menu
    
    @objc private func handlepanGesture(sender: UIPanGestureRecognizer) {
        guard gestrueEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state{
        case .began:
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0 , self.isExpanded {
                sender.state = .cancelled
            }
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging they collapsing the side menu)
            else if velocity < 0, self.isExpanded{
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                 // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                 let velocityThreshold: CGFloat = 550
                 if abs(velocity) > velocityThreshold {
                     self.sideMenuState(expanded: self.isExpanded ? false : true)
                     self.draggingIsEnabled = false
                     return
                 }

                 if self.revealSideMenuOnTop {
                     self.panBaseLocation = 0.0
                     if self.isExpanded {
                         self.panBaseLocation = self.sideMenuRevealWidth
                     }
                 }
             }
            
        case .changed:
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth

                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha

                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                       // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth

                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha

                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animationse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}
            


// connect the ViewControllers with  mainVC
//this extension can access the MainVC from the child view controllers.

extension UIViewController {
    func revealViewController() -> MainVC? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is MainVC {
            return viewController! as? MainVC
        }
        while (!(viewController is MainVC) && viewController?.parent != nil){
            viewController = viewController?.parent
        }
        if viewController is MainVC{
            return viewController as? MainVC
        }
        return nil
    }
}
