//
//  walkthroughViewController.swift
//  QueueTime
//
//  Created by Tim van der Zee on 21/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import UIKit

class walkthroughViewController: UIViewController, walkthroughPageViewControllerDelegate {
    
    // Outlets
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton!
    {
        didSet{
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var skipButton: UIButton!
    
    // Properties
    
    var walkthroughPageViewController: walkthroughPageViewController?
    
    
    // Actions
    
    @IBAction func skipButtonTapped(sender: UIButton)
    {
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton)
    {
        if let index = walkthroughPageViewController?.currentIndex
        {
            switch index
            {
            case 0...1:
                walkthroughPageViewController?.forwardPage()
                
            case 2:
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                dismiss(animated: true, completion: nil)
                
            default: break
            }
        }
        updateUI()
    }
    
    func updateUI()
    {
        if let index = walkthroughPageViewController?.currentIndex
        {
            switch index
            {
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
                
            case 2:
                nextButton.setTitle("GET STARTED", for: .normal)
                skipButton.isHidden = true
                
            default: break
            }
            
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    // View Controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? walkthroughPageViewController
        {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
 

}
