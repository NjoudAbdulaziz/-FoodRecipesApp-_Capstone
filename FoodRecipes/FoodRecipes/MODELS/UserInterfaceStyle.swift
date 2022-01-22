//
//  UserInterfaceStyle.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 19/06/1443 AH.
//

import UIKit
// Dark Mode..
//MARK:- User Interface Style Manager:
  /*
 - Keep track of the app’s current user interface style.
 - Keep track of all the user interface style observers.
 - In charge of notifying all the observers when interface style changes.
 */
struct UserInterfaceStyleManager {
    
    static let userInterfaceStyleDarkModeOn = "userInterfaceStyleDarkModeOn"
    /*
    Making the UserInterfaceStyleManager singleton by creating a static shared instance and setting its initializer to private.
    */
    static var shared = UserInterfaceStyleManager()
    /*
     Observers is a dictionary that keeps track of all the observers being added. Note that observers are being added as weak reference into the dictionary, this is to avoid retain cycle from happening (more on that later). Furthermore, we are using ObjectIdentifier of the observer as the dictionary key.
     */
    private var observers = [ObjectIdentifier : WeakStyleObserver]()
    
    private init() { }
   /*
    currentStyle is a private variable that use to keep track of the current user interface style. Here, we obtain its initial value from UserDefaults.
    */
    private(set) var currentStyle: UIUserInterfaceStyle = UserDefaults.standard.bool(forKey: UserInterfaceStyleManager.userInterfaceStyleDarkModeOn) ? .dark : .light {
        // Property observer to trigger every time value is set to currentStyle
        didSet {
            if currentStyle != oldValue {
                // Trigger notification when currentStyle value changed
                styleDidChanged()
            }
        }
    }
}

// MARK:- Public functions
/*
 Create public function updateUserInterfaceStyle(_:) to allow other component of the app, in our case will be the UISwitch, to inform our UserInterfaceStyleManager about user interface style being changed.
 */
extension UserInterfaceStyleManager {
    //enables other components to add observers to UserInterfaceStyleManager.
    mutating func addObserver(_ observer: UserInterfaceStyleObserver) {
        let id = ObjectIdentifier(observer)
        // Create a weak reference observer and add to dictionary
        observers[id] = WeakStyleObserver(observer: observer)
    }
    //enables other components to remove observer from UserInterfaceStyleManager.
    mutating func removeObserver(_ observer: UserInterfaceStyleObserver) {
        let id = ObjectIdentifier(observer)
        observers.removeValue(forKey: id)
    }
    
    mutating func updateUserInterfaceStyle(_ isDarkMode: Bool) {
        currentStyle = isDarkMode ? .dark : .light
    }
}



// MARK:- Private functions
private extension UserInterfaceStyleManager {
    /*
     The styleDidChanged() function in the snippet above will iterate through the observers dictionary and notify each observer about the user interface style change.
     */
    mutating func styleDidChanged() {
        for (id, weakObserver) in observers {
            // Clean up observer that no longer in memory
            guard let observer = weakObserver.observer else {
                observers.removeValue(forKey: id)
                continue
            }
            
            // Notify observer by triggering userInterfaceStyleManager(_:didChangeStyle:)
            observer.userInterfaceStyleManager(self, didChangeStyle: currentStyle)
        }
    }
}

//-----------------------------------------------------------------

//MARK:- User Interface Style Observer:
//A class-only protocol so that only class can conform to the protocol.
  /*
  - A protocol that observe interface style changes in the User Interface Style Manager.
  - In charge of updating the view appearance when user interface style changes.
 */
protocol UserInterfaceStyleObserver: class {
    //Charge of adding observers to UserInterfaceStyleManager
    func startObserving(_ userInterfaceStyleManager: inout UserInterfaceStyleManager)
    //will trigger when user interface style changes.Take care of changing the view appearance whenever it is needed.
    func userInterfaceStyleManager(_ manager: UserInterfaceStyleManager, didChangeStyle style: UIUserInterfaceStyle)
}


extension UIViewController: UserInterfaceStyleObserver {
    
    func startObserving(_ userInterfaceStyleManager: inout UserInterfaceStyleManager) {
        // Add view controller as observer of UserInterfaceStyleManager
        userInterfaceStyleManager.addObserver(self)
        
        // Change view controller to desire style when start observing
        overrideUserInterfaceStyle = userInterfaceStyleManager.currentStyle
    }
    
    func userInterfaceStyleManager(_ manager: UserInterfaceStyleManager, didChangeStyle style: UIUserInterfaceStyle) {
        // Set user interface style of UIViewController
        overrideUserInterfaceStyle = style
        
        // Update status bar style
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension UIView: UserInterfaceStyleObserver {
    
    func startObserving(_ userInterfaceStyleManager: inout UserInterfaceStyleManager) {
        // Add view as observer of UserInterfaceStyleManager
        userInterfaceStyleManager.addObserver(self)
        
        // Change view to desire style when start observing
        overrideUserInterfaceStyle = userInterfaceStyleManager.currentStyle
    }
    
    func userInterfaceStyleManager(_ manager: UserInterfaceStyleManager, didChangeStyle style: UIUserInterfaceStyle) {
        // Set user interface style of UIView
        overrideUserInterfaceStyle = style
    }
}


//-----------------------------------------------------------------

//MARK:- Weak Style Observer :
/*
 - is a wrapper type that keep track of a UserInterfaceStyleObserver instance with a weak reference.
 
 - The reason we need this is because that dictionaries in Swift always have strong reference to their elements, this will potentially introduce retain cycle and causing memory leak.
 */

struct WeakStyleObserver {
    weak var observer: UserInterfaceStyleObserver?
}
