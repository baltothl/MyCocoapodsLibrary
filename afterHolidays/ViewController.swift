//
//  ViewController.swift
//  afterHolidays
//
//  Created by btoth on 17/8/21.
//

import UIKit
import SwiftSpinner

class ViewController: UIViewController {
  
    @IBOutlet var labelContainerView: UIView!
    var progress = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func delay(seconds: Double, completion: @escaping () -> ()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.demoSpinner()
    }
    
    func demoSpinner() {
        UIView.animate(withDuration: 0.5) {
           
        }

        SwiftSpinner.show(delay: 0.5, title: "Shouldn't see this one", animated: true)
        SwiftSpinner.hide()
        
        SwiftSpinner.show(delay: 1.0, title: "Connecting...", animated: true)
        
        delay(seconds: 2.0, completion: {
            SwiftSpinner.show("Connecting \nto satellite...").addTapHandler({
                print("tapped")
                SwiftSpinner.hide()
            }, subtitle: "Tap to hide while connecting! This will affect only the current operation.")
        })
        
        delay(seconds: 6.0, completion: {
            SwiftSpinner.show("Authenticating user account")
        })
        
        delay(seconds: 10.0, completion: {
            SwiftSpinner.shared.outerColor = UIColor.red.withAlphaComponent(0.5)
            SwiftSpinner.setTitleColor(UIColor.red)
            SwiftSpinner.show("Failed to connect, waiting...", animated: false)
        })
        
        delay(seconds: 14.0, completion: {
            SwiftSpinner.shared.outerColor = nil
            SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 22.0))
            SwiftSpinner.setTitleColor(UIColor.white)
            SwiftSpinner.show("Retrying to authenticate")
        })
        
        delay(seconds: 18.0, completion: {
            SwiftSpinner.setTitleColor(UIColor.green)
            SwiftSpinner.show("Connecting...")
        })
        
        delay(seconds: 21.0, completion: {
            SwiftSpinner.setTitleFont(nil)
            SwiftSpinner.shared.innerColor = UIColor.green.withAlphaComponent(0.5)
            SwiftSpinner.show(duration: 2.0, title: "Connected", animated: false)
        })

        delay(seconds: 24.0) {
            SwiftSpinner.setTitleColor(UIColor.white)
            SwiftSpinner.shared.innerColor = nil
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerFire), userInfo: nil, repeats: true)
        }
        
        delay(seconds: 34.0, completion: {
            self.demoSpinner()
        })
    }
    
    @objc func timerFire(_ timer: Timer) {
        progress += (timer.timeInterval/5)
        SwiftSpinner.show(progress: progress, title: "Downloading: \(Int(progress * 100))% completed")
        if progress >= 1 {
            progress = 0
            timer.invalidate()
            SwiftSpinner.show(duration: 2.0, title: "Complete!", animated: false)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
