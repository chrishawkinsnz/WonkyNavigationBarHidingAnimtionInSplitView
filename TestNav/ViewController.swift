//
//  ViewController.swift
//  TestNav
//
//  Created by Chris Hawkins on 10/5/18.
//  Copyright © 2018 Chris Hawkins. All rights reserved.
//

import UIKit

class PusherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.navigationItem.title = "Title"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 999999
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "push", sender: nil)
    }
    
}

class PushedViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func didSelectButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

class RootViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        // Do some dirty digging and add a dismiss button to the navigation bar for the presented VCs
        if let navigationController = destination as? UINavigationController {
            navigationController.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Dismiss", style: .plain, target: self, action: #selector(dismissModal))
        }
        if let navigationController = ((destination as? UISplitViewController)?.viewControllers.first as? UINavigationController) {
            navigationController.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Dismiss", style: .plain, target: self, action: #selector(dismissModal))
        }
    }
    
    @objc
    func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
}
