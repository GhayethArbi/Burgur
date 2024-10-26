//
//  OrderViewController.swift
//  EamenRevGhayeth
//
//  Created by Mac-Mini-2021 on 26/10/2024.
//

import UIKit
import CoreData

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //var
    var burgers = [String]()
    
    //tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return burgers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
        
        label.text = burgers[ indexPath.row]
       
        
        return cell!
    }
    
    
    
    
    
    
    
    //fetch all
    func fetchAll(){
        //app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
        //persistContainer
        let persistContainr = appDelegate.persistentContainer
            
        //copy managedContext
        let managedContext = persistContainr.viewContext
            
        //req
        let req = NSFetchRequest<NSManagedObject>(entityName: "Humburger")
            
        //exec
        do {
            let sandwitch = try managedContext.fetch(req)
            for item in sandwitch{
                burgers.append(String(item.value(forKey: "prixBurgur")as! Float)+"$")
                print(item.value(forKey: "prixBurgur") as! Float)
                    
            }
                
        } catch  {
            print("Failed: fetch error")
        }
    }
    
    
    
    //didload
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchAll()
        // Do any additional setup after loading the view.
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
