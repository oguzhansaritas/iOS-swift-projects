//
//  ViewController.swift
//  SwiftTesting
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
// To do List App

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    var todoList : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
    }

    @IBAction func addButton(_ sender: Any) {
        // navigation bar button item add function
        let alert = UIAlertController(title: "Add Item", message: "Enter your to do item", preferredStyle: .alert)
        alert.addTextField{textField in textField.placeholder = "Enter Item"}
        let okbutton = UIAlertAction(title: "OK", style: .default) { action in
            guard let textField = alert.textFields?[0], let inputText = textField.text, !inputText.isEmpty else{
                return
            }// end else
            self.todoList.insert(inputText, at: 0)
            self.tableView.insertRows(at: [.init(row: 0, section: 0)], with: .automatic) // add to table view first place
        }// end completion
        alert.addAction(okbutton)
        self.present(alert,animated: true)
        
    }// end function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }// end function
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = todoList[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }// end function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }// end if

    }// end Function
    
    
}// end class

