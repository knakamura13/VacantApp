//
//  View2.swift
//  VacantApp2.0
//
//  Created by Kyle Nakamura on 10/5/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit

class View2: UIViewController {

    @IBOutlet weak var occupiedSignLbl: UILabel!
    @IBOutlet weak var vacantSignLbl: UILabel!
    @IBOutlet weak var signSwitcherView: UIView!
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    
    var counterVal = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        counterLbl.text = "0"
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        if counterVal < 2 {
            counterVal += 1
        }
        counterLbl.text = String(counterVal)
        
        checkVacancy(count: counterVal)
    }
    
    @IBAction func removeBtnPressed(_ sender: Any) {
        if counterVal > 0 {
            counterVal -= 1
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
