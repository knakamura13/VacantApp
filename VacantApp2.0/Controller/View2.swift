//
//  View2.swift
//  VacantApp2.0
//
//  Created by Kyle Nakamura on 10/5/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit
import Firebase

class View2: UIViewController {

    // Outlets
    @IBOutlet weak var occupiedSignLbl: UILabel!
    @IBOutlet weak var vacantSignLbl: UILabel!
    @IBOutlet weak var signSwitcherView: UIView!
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    
    // Variables
    var counterVal = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        addBtn.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        removeBtn.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        counterLbl.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        
        addBtn.layer.shadowOpacity = 0.7
        removeBtn.layer.shadowOpacity = 0.7
        counterLbl.layer.shadowOpacity = 0.7
        
        addBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        removeBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        counterLbl.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        counterVal = womenCounter
        counterLbl.text = String(counterVal)
        
        // Continously listen for database value change
        database.child("stats").observe(.childChanged, with: { (snapshot) -> Void in
            // Listen once for womenOccupancy value change
            database.child("stats").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let firebaseCount = value?["womenOccupancy"] as? Int ?? 0
                self.counterVal = firebaseCount
                self.counterLbl.text = String(self.counterVal)
                self.checkVacancy(count: self.counterVal)
            })
        })
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        if counterVal < 2 {
            counterVal += 1
            database.child("stats").child("womenOccupancy").setValue(counterVal)
        }
        
        counterLbl.text = String(counterVal)
        checkVacancy(count: counterVal)
    }
    
    @IBAction func removeBtnPressed(_ sender: Any) {
        if counterVal > 0 {
            counterVal -= 1
            database.child("stats").child("womenOccupancy").setValue(counterVal)
        }
        
        counterLbl.text = String(counterVal)
        checkVacancy(count: counterVal)
    }
    
    func checkVacancy(count: Int) {
        if count <= 1 {
            occupiedSignLbl.isHidden = true
            vacantSignLbl.isHidden = false
        } else {
            occupiedSignLbl.isHidden = false
            vacantSignLbl.isHidden = true
        }
    }
}
