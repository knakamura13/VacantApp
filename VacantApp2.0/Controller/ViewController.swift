//
//  ViewController.swift
//  VacantApp2.0
//
//  Created by Kyle Nakamura on 10/5/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit
import Foundation
import Firebase

var menCounter = 0
var womenCounter = 0

let database = Database.database().reference()

class ViewController: UIViewController, UIScrollViewDelegate {

    // Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.2419321835, green: 0.4332072735, blue: 0.5136573911, alpha: 1)
        scrollView.delegate = self
        
        setupScrollViewFrames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        database.child("stats").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let firebaseLaunched = value?["launched"] as? Int ?? 0
            let firebaseMen = value?["menOccupancy"] as? Int ?? 0
            let firebaseWomen = value?["womenOccupancy"] as? Int ?? 0
            
            menCounter = firebaseMen
            womenCounter = firebaseWomen
            database.child("stats").child("launched").setValue(firebaseLaunched + 1)
        })
    }
    
    func setupScrollViewFrames() {
        let V1: View1 = View1(nibName: "View1", bundle: nil)    // Men's page
        let V2: View2 = View2(nibName: "View2", bundle: nil)    // Women's page
        
        // Add first view to scrollview
        self.addChildViewController(V1)
        self.scrollView.addSubview(V1.view)
        V1.didMove(toParentViewController: self)
        
        // Add second view to scrollview
        self.addChildViewController(V2)
        self.scrollView.addSubview(V2.view)
        V2.didMove(toParentViewController: self)
        
        // Place view2 to the right of view1
        var V2Frame: CGRect = V2.view.frame
        V2Frame.origin.x = self.view.frame.width
        V2.view.frame = V2Frame
        
        if #available(iOS 11.0, *) {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width*2, height: view.safeAreaLayoutGuide.layoutFrame.size.height)
        } else {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width*2, height: view.frame.size.height)
        }
    }
    
    // Change status bar color when scrolling stops
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        if page == 0 {
            UIView.animate(withDuration: 0.4, delay: 0.0, animations: {
                self.view.backgroundColor = #colorLiteral(red: 0.2419321835, green: 0.4332072735, blue: 0.5136573911, alpha: 1)
            }, completion:nil)
        } else if page == 1 {
            UIView.animate(withDuration: 0.4, delay: 0.0, animations: {
                self.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            }, completion:nil)
        } else {
            self.view.backgroundColor = UIColor.black
        }
    }
}

