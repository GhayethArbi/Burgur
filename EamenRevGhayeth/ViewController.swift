//
//  ViewController.swift
//  EamenRevGhayeth
//
//  Created by Mac-Mini-2021 on 22/10/2024.
//

import UIKit
import  CoreData

class ViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
  
    
    
    //var
    var supplement = ["Arugula","Bacon","Cheddar","Cucumber","Egg","Gruyere","Ham","Lettuce","Mashroom","Ognion","Tomato"]
    var patte = ["Top","Bottom"]
    var price = [19, 23, 2, 19, 5, 23, 2, 19, 5, 23, 2, 19, 5]
    var prixI = 2
    
    
    
    
    
    
    
    
    //actions
    @IBAction func insertBurger(_ sender: Any) {
        insertBurgur()
        let alert = UIAlertController (title: "Success", message: "Burgur add it", preferredStyle: .alert )
        let action = UIAlertAction(title: "Go it!", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
        
        
    }
    
    
  /*  @IBAction func fetchBurgur(_ sender: Any) {
        fetchAll()
    }*/
    
    
    
    //outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var prixTotal: UILabel!
    
    
    
    
    
    
    // UICollectionView DataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return supplement.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let col = collectionView.dequeueReusableCell(withReuseIdentifier: "mCol", for: indexPath)
            
        // Find the image view and label by their tags
        if let imageView = col.viewWithTag(1) as? UIImageView {
            imageView.image = UIImage(named: supplement[indexPath.row])  // Set image for each cell
        }
            
        if let label = col.viewWithTag(2) as? UILabel {
            label.text = String(price[indexPath.row] )+"$"// Set price label for each cell
        }

        return col
    }
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = supplement[indexPath.row]
        patte.insert(item, at: 1)
        
        prixI = prixI + price[indexPath.row]
        prixTotal.text = String(prixI)+"$"
        tableView.reloadData()
    }
    
    
    
    
    //widget table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patte.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let imageview = contentView?.viewWithTag(4) as! UIImageView
        imageview.image = UIImage(named: patte[indexPath.row])
        
        return cell!
        
    }
    //scrolldelete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                if  indexPath.row != 0 && indexPath.row != (patte.count - 1){

                let item = patte[indexPath.row]
                let indx = supplement.firstIndex(of: item)
                    
                //remove from this table
                patte.remove(at: indexPath.row)
                prixI = prixI - price[indx!]
                prixTotal.text = String(prixI)+"$"
                    
                //update table
                tableView.reloadData()
            }
            else{
                print("last one patte")
                
            }
        }
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
                // patte.append(item.value(forKey: "supplement")as! String)
                print(item.value(forKey: "prixBurgur") as! Float)
                    
            }
                
        } catch  {
            print("Failed: fetch error")
        }
    }

    
    
    
    // insert
    func insertBurgur(){
        //app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
           
        //persistContainer
        let persistContainr = appDelegate.persistentContainer
           
        //copy managedContext
        let managedContext = persistContainr.viewContext
           
        //article vide
        let entityDesc = NSEntityDescription.entity(forEntityName: "Humburger", in: managedContext)
           
        //obj
        let obj = NSManagedObject(entity: entityDesc!, insertInto: managedContext)
        
        //add value
        obj.setValue(prixI, forKey: "prixBurgur")
           
        //push
        do {
            try managedContext.save()
        } catch  {
            print("Failed: insert error")
        }
           
    }
    
    
    
    
    
    //didload
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchAll()
        // Do any additional setup after loading the view.
    }


}

