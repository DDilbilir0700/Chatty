//
//  ChattyVC.swift
//  Chatty
//
//  Created by Deniz Dilbilir on 02/10/2023.
//

import UIKit
import Firebase




class ChattyVC: UIViewController {
  
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chatTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    
    let db = Firestore.firestore()
    
    var texts: [Messages] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.isTranslucent = false
        scrollView.contentInsetAdjustmentBehavior = .automatic
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: chatTextField.frame.height))

         
          chatTextField.leftView = paddingView
          chatTextField.leftViewMode = .always
        
        chatTextField.layer.cornerRadius = chatTextField.frame.size.height/8
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellID)
        
        
        
        retrieveMessage()
        
        
        
    }
    
    func retrieveMessage() {
        
        db.collection(Constants.Parts.chatName).order(by: Constants.Parts.dateName).addSnapshotListener { querySnapshot, error in
            self.texts = []
            
            if let err = error {
                print("Another issue \(err)")
            } else {
               if let snapshotDoc = querySnapshot?.documents {
                   for doc in snapshotDoc {
                       let data = doc.data()
                       if let sender = data[Constants.Parts.senderName] as? String, let textBody = data[Constants.Parts.bodyName] as? String {
                           let newText = Messages(senderEmail: sender, body: textBody)
                           self.texts.append(newText)
                    
                           
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                               let indexPath = IndexPath(row: self.texts.count - 1, section: 0)
                               self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                               
                           }
                           
                           
                       }
                   }
                }
            }
        }
    }

    @IBAction func sendButton(_ sender: UIButton) {
        if let chatBody = chatTextField.text, let chatSender = Auth.auth().currentUser?.email {
            db.collection(Constants.Parts.chatName).addDocument(data: [Constants.Parts.senderName: chatSender, Constants.Parts.bodyName: chatBody, Constants.Parts.dateName: Date().timeIntervalSince1970]) { error in
                if let crashy = error {
                    print("issues to myself \(crashy)")
                } else {
                    print("Done!")
                 
                    DispatchQueue.main.async {
                        self.chatTextField.text = ""
                    }
                }
                
            }
        }
    }
    
    

    
    @IBAction func signOutButton(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

extension ChattyVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = texts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! ChatCell
        cell.chattyLabel.text = text.body
        
        if text.senderEmail == Auth.auth().currentUser?.email {
            cell.youAvatar.isHidden = true
            cell.selfAvatar.isHidden = false 
            cell.TextSpace.backgroundColor = UIColor(named: Constants.specialColors.orangeAndNavy)
            cell.chattyLabel.textColor = UIColor.white
            
        } else {
            cell.youAvatar.isHidden = false
            cell.selfAvatar.isHidden = true
            cell.TextSpace.backgroundColor = UIColor(named: Constants.specialColors.navyAndOrange)
            cell.chattyLabel.textColor = UIColor.white
        }
        return cell
    }
    
    
}


