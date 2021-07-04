//
//  DetailVC.swift
//  Demo
//
//  Created by Admin on 04/07/21.
//

import UIKit

class DetailVC: UIViewController {

    var user:UserData?
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var homeNumberLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var zipCodeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "User Details"

        self.setData()

        // Do any additional setup after loading the view.
    }
    
    func setData() {
        self.nameLbl.text = user?.name
        self.emailLbl.text = user?.email
        self.phoneLbl.text = user?.mobile
        self.homeNumberLbl.text =  user?.homeNumber
        self.zipCodeLbl.text    = user?.zipCode
        self.addressLbl.text = user?.address
    }
  
}
