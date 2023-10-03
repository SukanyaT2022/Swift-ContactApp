//
//  ViewController.swift
//  contact-app
//
//  Created by Tiparpron Sukanya on 9/28/23.
//

import UIKit

class ViewController: UIViewController {
    
    //connect 1-control drag from table view -main
    @IBOutlet weak var contactTableView: UITableView!
    //connect 2-control drag from segment -main
    @IBOutlet weak var contactSegment: UISegmentedControl!
    var allContactList: [Contact]?//Contct from entity
    var favouriteContactList: [Contact]?
    var contactList: [Contact]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactTableView.delegate = self
        contactTableView.dataSource = self
        createRightBarButton()
    }
    
    //this below create add section on the right corner
    func createRightBarButton(){
        let barButton = UIBarButtonItem(title: "Add" , style: .plain, target: self, action:#selector(rightBarButtonTapped))
        self.navigationItem.rightBarButtonItem = barButton
    }
    @objc func rightBarButtonTapped(){
        self.performSegue(withIdentifier: "createNavConnect", sender: nil)
    }
//connnect 3- control drag segment again
    @IBAction func contactSegmentAction(_ sender: UISegmentedControl) {
    }
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  contactList?.count ??  0 // if contact list is nile so we show 0 for default value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for:indexPath)  //crate cell with identify and index path
        return cell
    }
    
    
}
