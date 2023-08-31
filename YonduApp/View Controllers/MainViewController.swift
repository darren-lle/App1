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
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    
    private var user: User!
    private var adapter: ListCollectionViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareTableView()
        getUserProfile()
        getRewards()
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
            
            vc.set(sender as? Rewards)
        }
    }
    
    func set(_ user: User) {
        self.user = user
    }
}

private extension MainViewController {
    func prepareTableView() {
        adapter = ListCollectionViewAdapter(collectionView: listCollectionView, delegate: self)
    }
    
    func loadRewards(_ rewards: [Rewards]) {
        adapter?.set(data: rewards)
    }
    
    func loading(_ loading: Bool) {
        progressIndicatorView.isHidden = !loading
        loading ? progressIndicatorView.startAnimating() : progressIndicatorView.stopAnimating()
    }
    
    func getUserProfile() {
        nameLabel.text = nil
        mobileNumLabel.text = nil
        referralLabel.text = nil
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            UserProfileRequestHandler().profileRequest(for: self.user) { [weak self] user, message in
                
                guard let user = user else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.displayUserProfile(user)
                }
            }
        }
    }
    
    func displayUserProfile(_ user: User) {
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        mobileNumLabel.text = user.mobile
        referralLabel.text = user.referralCode ?? "----"
    }
    
    func getRewards() {
        loading(true)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            RewardsListRequestHandler().requestRewards { rewards, message in
                DispatchQueue.main.async {
                    self?.loading(false)
                    
                    if let rewards = rewards {
                        self?.loadRewards(rewards)
                        return
                    }
                    
                    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
                        self?.getRewards()
                    })
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
                    
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

extension MainViewController: ListCollectionViewAdapterDelegate {
    func didSelect(_ item: Rewards) {
        performSegue(withIdentifier: "showMoreDetails", sender: item)
    }

}

