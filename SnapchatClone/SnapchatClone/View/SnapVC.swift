//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import Kingfisher
import ImageSlideshow
import ImageSlideshowKingfisher
class SnapVC: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap : SnapModel?

    var inputArray = [KingfisherSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        if let snap = selectedSnap{
            timeLabel.text = "Time Left: \(snap.timeDifference) Hours."
            for imageUrl in snap.imageUrlArray{
                inputArray.append(KingfisherSource(url: URL(string: imageUrl)!))
                
            }
            // Setting Image Slide Show
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width*0.95, height: self.view.frame.height*0.7))
            imageSlideShow.backgroundColor = .white
            
            // Setting Indicator
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = .lightGray
            pageIndicator.pageIndicatorTintColor = .black
            imageSlideShow.pageIndicator = pageIndicator
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLabel)
            
            
            
            
            
            
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
