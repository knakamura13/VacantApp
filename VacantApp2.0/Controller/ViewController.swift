//
//  ViewController.swift
//  VacantApp2.0
//
//  Created by Kyle Nakamura on 10/5/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        self.view.backgroundColor = #colorLiteral(red: 0.2419321835, green: 0.4332072735, blue: 0.5136573911, alpha: 1)
        
        setupScrollViewFrames()
    }
    
    func setupScrollViewFrames() {
        let V1: View1 = View1(nibName: "View1", bundle: nil)
        let V2: View2 = View2(nibName: "View2", bundle: nil)
        
        self.addChildViewController(V1)
        self.scrollView.addSubview(V1.view)
        V1.didMove(toParentViewController: self)
        
        self.addChildViewController(V2)
        self.scrollView.addSubview(V2.view)
        V2.didMove(toParentViewController: self)
        
        var V2Frame: CGRect = V2.view.frame
        V2Frame.origin.x = self.view.frame.width
        V2.view.frame = V2Frame
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width*2, height: view.safeAreaLayoutGuide.layoutFrame.size.height)
    }
    
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

