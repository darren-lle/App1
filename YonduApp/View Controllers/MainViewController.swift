//
//  MainViewController.swift
//  YonduExam
//
//  Created by Darren Lester Erandio on 8/30/23.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumLabel: UILabel!
    @IBOutlet weak var referralLabel: UILabel!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    private var adapter: ListCollectionViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMoreDetails" {
            guard let vc = segue.destination as? DetailViewController else {
                return
            }
            
            vc.set(sender as? Item)
        }
    }

}

private extension MainViewController {
    func prepareTableView() {
        adapter = ListCollectionViewAdapter(collectionView: listCollectionView, delegate: self)
        
        var items: [Item] = []
        
        for ctr in 0..<5 {
            items.append(Item(title: "Title \(ctr)", moreDetails: "More Details: \(ctr)", imageURL: "https://fujifilm-x.com/wp-content/uploads/2021/01/gfx100s_sample_04_thum-1.jpg"))
        }
        
        adapter?.set(data: items)
    }
}

extension MainViewController: ListCollectionViewAdapterDelegate {
    func didSelect(_ item: Item) {
        performSegue(withIdentifier: "showMoreDetails", sender: item)
    }
}

