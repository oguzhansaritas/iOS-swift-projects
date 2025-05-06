

import UIKit
import Firebase

// Chat View


class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages : [Message] = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // To hide back button on Chat screen
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        

    }
    func loadMessages(){
        
        // Request for  messages to database with our collection name
        // for getting data just for once we need to use .getDocuments
        // but if wanted always update need to use .addSnapshotListener
        // For more, https://firebase.google.com/docs/firestore/query-data/listen?hl=en&authuser=0
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener{ snapshot, error in
            // Clear meesages array
            self.messages = []
            
            if error != nil{
                // for error shows error alert to user
                self.errorAlert(title: "Error", message: error!.localizedDescription)
            }else{
                // Getting data as an Array we can access one by one with for loop
                if let snapshotDocuments = snapshot?.documents{
                    for document in snapshotDocuments{
                        // data
                        let data = document.data()
                        // sender mail as string from data
                        if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            // Create message object and add to array
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            // Must be Async because of the internet connection or something else
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }// end async
                        }// end if let
                    }// end for
                }// end if let
            }// end else
        }// end closure
    }// end closure
    @IBAction func sendPressed(_ sender: UIButton) {
        // Checking mail & message
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            // Creating or load to Collection on Firestore. Send to database messages and the owner e-mail.
            
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField:messageSender,K.FStore.bodyField:messageBody,K.FStore.dateField:Date.timeIntervalSinceReferenceDate]) { error in
                if let e = error{
                    //Check error and show to user
                    self.errorAlert(title: "Error", message: e.localizedDescription)
                }else{
                    //Message saved succuesfully. Clear the text field.
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
        
        
        
        
        
    }
    @IBAction func logOutPressed(_ sender: Any) {
        // Firebase Log Out
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch {
            print("Sign Out Error.")
        }
        
    }
    

}

extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text =  messages[indexPath.row].body
        let message = messages[indexPath.row]
        if message.sender  == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
            
        }else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        return cell
    }

}
extension ChatViewController{
    func errorAlert(title:String,message:String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true,completion: nil)
                
            }
}
