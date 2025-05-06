//
//  FeedViewController.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class FeedViewController: UIViewController {

    @IBOutlet weak var greetingMessageLabel: UILabel!
    @IBOutlet weak var tableView : UITableView!
    private var newsListViewModel : NewsListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        //getUsername()
        getRecentNews()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getUsername()
    }
    func getUsername(){
        // call the database
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser?.email
        
        // Find the account owners field
        db.collection("userInfo").whereField("user_Mail", isEqualTo: currentUser!).getDocuments { snapshot, error in
            if error != nil{
                // Check Error
                print("Error.")
            }else{
                // Take Username for using in Feed VC
                for document in snapshot!.documents{
                    let name = document.get("name")
                    self.greetingMessageLabel.text =  "\(String(describing: name ?? ""))"
                }//end for
            }//end else
        }// end closure
        
    }// end func
    
    func getRecentNews(){
        WebService().getNews(url: URL(string: K.newsURL)!) { news in
            if let news = news{
                self.newsListViewModel = NewsListViewModel(newsList: news)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }// end async
            }//end if
        }// end closure
    }//end func
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        // Call the function and will reload the Table with new News.
        getRecentNews()
    }
    

}
// MARK: - TableView
extension FeedViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let news = newsListViewModel?.newsList.articles
        return news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell,for:indexPath) as! NewsCell
        let news = newsListViewModel?.newsList.articles
        cell.headlineLabel.text = news?[indexPath.row].title
        cell.previewLabel.text = news?[indexPath.row].articleDescription
                
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Detect which article choosen
        let news = newsListViewModel?.newsList.articles
        let choosedarticle = news![indexPath.row]
        performSegue(withIdentifier: K.Segue.newsDetailSegue, sender: choosedarticle)
    }
    // Segue Preperation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.newsDetailSegue{
            if let article = sender as? Article{
                let destinationVC = segue.destination as! NewsDetailViewController
                destinationVC.choosenArticle = article
            }
        }
    }
    
}
