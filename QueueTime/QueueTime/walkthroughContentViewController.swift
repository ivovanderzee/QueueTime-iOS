//
//  walkthroughContentViewController.swift
//  QueueTime
//
//  Created by Tim van der Zee on 21/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import UIKit

class walkthroughContentViewController: UIViewController {
    
    // Outlets
    @IBOutlet var  headingLabel:UILabel!
        {
        didSet
        {
            headingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var subHeadingLabel: UILabel!
        {
        didSet
        {
            subHeadingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var contentImageView: UIImageView!
    
    // Properties
    
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
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
