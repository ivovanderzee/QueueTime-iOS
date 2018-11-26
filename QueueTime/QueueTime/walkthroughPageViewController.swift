//
//  walkthroughPageViewController.swift
//  QueueTime
//
//  Created by Tim van der Zee on 21/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import UIKit
protocol walkthroughPageViewControllerDelegate: class
{
    func didUpdatePageIndex(currentIndex: Int)
}

class walkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // Properties
    weak var walkthroughDelegate: walkthroughPageViewControllerDelegate?
    
    var pageHeadings = ["BEKIJK FILES", "MAAK VRIENDEN", "DEEL FILELEED"]
    var pageImages = ["onboarding-1","onboarding-2","onboarding-3"]
    var pageSubHeadings = ["Zie alle files bij jou in de buurt op 1 plek.","Maak vrienden terwijl je in de file zit.","Deel je fileleed met anderen die in de file staan."]
    
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the data source and delegate to itself
        dataSource = self
        delegate = self
        
        // Create first walkthrough screen
        if let startingViewController = contentViewController(at: 0)
        {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // Page View Controller Data Source

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! walkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! walkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    // Helper
    
    func contentViewController(at index: Int) -> walkthroughContentViewController?
    {
        if index < 0 || index >= pageHeadings.count
        {
            return nil
        }
        
        // Create new View Controller and pass the right data
        let storyboard = UIStoryboard(name: "onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "walkthroughContentViewController") as? walkthroughContentViewController
        {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    
    func forwardPage()
    {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex)
        {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // Page View Controller delegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed
        {
            if let contentViewController = pageViewController.viewControllers?.first as? walkthroughContentViewController
            {
                currentIndex = contentViewController.index
                
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
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
