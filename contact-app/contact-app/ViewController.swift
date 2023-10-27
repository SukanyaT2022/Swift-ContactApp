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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchContact()
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
            fetchContact()
    }
    
    func fetchContact(){
        let fetchRequest = Contact.fetchRequest()
        contactList = try? (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.fetch(fetchRequest)
        if contactSegment.selectedSegmentIndex == 1{
            contactList = contactList?.filter({$0.isFavourite == true})
        //if select 1 index which is favourite show only favourite if not one so it index 0 menas all show all data
        }
        contactTableView.reloadData()
        
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  contactList?.count ??  0 // if contact list is nile so we show 0 for default value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell",  for:indexPath) as? ContactTableViewCell
        let contact = contactList?[indexPath.row]//contactList is array of contact line 44 from database from particular row[indexpath.row] means each row
        cell?.nameLabel.text = contact?.name
        cell?.contactData = contact//which cell
        //crate cell with identify and index path
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ContactTableViewCell
        performSegue(withIdentifier: "createNavConnect", sender: cell?.contactData)
        //next screen send data to next screen
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //prepae seque prepare data to next screen
        let detailVC = segue.destination as? CreateContactViewController// crate viewContoller to next destination
        if let contact = sender as? Contact{// check if sender have data or not
            detailVC?.contactData = contact//if have data send data
            detailVC?.isViewOnly = true
            
        }
        
            
    }
}
