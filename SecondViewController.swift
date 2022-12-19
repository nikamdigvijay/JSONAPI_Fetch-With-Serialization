//
//  SecondViewController.swift
//  ApiFatching
//
//  Created by Digvijay Nikam on 23/11/22.
//

import UIKit
import SDWebImage
class SecondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    
    var posts : [pods] = [pods]()
    
    @IBOutlet weak var SVCtabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataAndDelegate()
        registernib()
        downloadJSONData{
            self.SVCtabelView.reloadData()
        }
    }
    
    func registernib()
    {
        let uiNib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        self.SVCtabelView.register(uiNib, forCellReuseIdentifier: "TaskTableViewCell")
    }
    
    func dataAndDelegate()
    {
        SVCtabelView.dataSource = self
        SVCtabelView.delegate = self
    }

    
    func downloadJSONData(completed: @escaping() -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else {
            print("url not created")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if (error == nil){
                do{
                    let jsonDecoder = JSONDecoder()
                    self.posts = try! jsonDecoder.decode([pods].self, from: data!)
                
                }catch{
                    print("Error")
                    
                }
                
                DispatchQueue.main.async {
                    completed()
                }
            }
        }.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.SVCtabelView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        
        cell.LabelId.text = String(posts[indexPath.row].id)
        cell.LabelTitle.text = posts[indexPath.row].title
        cell.LabelBody.text = posts[indexPath.row].body
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let row = indexPath.row
            posts.remove(at: row)
            SVCtabelView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
//if (editingStyle == .delete){
//    let row = indexPath.row
//    posts.remove(at: row)
//    SVCtabelView.deleteRows(at: [indexPath], with: .automatic)
//}
