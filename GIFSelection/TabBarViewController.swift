//
//  TabBarViewController.swift
//  GIFSelection
//
//  Created by Erum Naz on 21/09/23.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
      
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 0 {
            if let firstVC = viewController as? ViewController {
                firstVC.setNewarray()
                   }
            
        } else if tabBarController.selectedIndex == 1 {
            if let secondVC = viewController as? SecondViewController {
                secondVC.setNewarray()
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
