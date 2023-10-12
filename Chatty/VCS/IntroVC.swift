//
//  IntroVC.swift
//  Chatty
//
//  Created by Deniz Dilbilir on 02/10/2023.
//

import UIKit

class IntroVC: UIViewController {

    @IBOutlet weak var isimLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animateLabel(text: Constants.appTitle, currentIndex: 0)
    }


    func animateLabel(text: String, currentIndex: Int) {
           if currentIndex < text.count {
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                   self.isimLabel.text = String(text.prefix(currentIndex + 1))
                   self.animateLabel(text: text, currentIndex: currentIndex + 1)
               }
           }
       }
   }
