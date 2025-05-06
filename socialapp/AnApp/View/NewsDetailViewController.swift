//
//  NewsDetailViewController.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import SafariServices
import Kingfisher

// News Detail Page

class NewsDetailViewController: UIViewController {
    
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    

    var choosenArticle : Article?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the News from selected row
        loadPage()
    }
    
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        // In app safari surfing with SafariServices moduler
        if let url = NSURL(string: (choosenArticle?.url)!){
            let destination = SFSafariViewController(url: url as URL)
            present(destination, animated: true, completion: nil)
        }// end if
    }// end button function

}// end class

extension NewsDetailViewController{
    func loadPage(){
        if choosenArticle != nil {
            // If data transport is successfully done, we can fill the labels
            headlineLabel.text = choosenArticle?.title
            descriptionLabel.text = choosenArticle?.articleDescription
            authorNameLabel.text = "Author: \(choosenArticle?.author! ?? "")"
            
            if let url = URL(string: choosenArticle?.urlToImage ?? K.notFoundImageUrl ){
                // Need to use async for Getting image from url
                DispatchQueue.main.async {
                    self.newsImage.kf.setImage(with: url)
                }// end async
            }// end if
        }// end if
    }// end function
}// end extension
