//
//  ViewController.swift
//  ApiFatching
//
//  Created by Digvijay Nikam on 20/11/22.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    @IBOutlet weak var tableViewToDisplayPods: UITableView!
    
    var post : [pods] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fatchinDataFormApi()
        dataAndDelegate()
        registerNib()
    }
   func dataAndDelegate(){
    tableViewToDisplayPods.dataSource = self
    tableViewToDisplayPods.delegate = self
    }
    
    func registerNib(){
        let uinib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        tableViewToDisplayPods.register(uinib, forCellReuseIdentifier: "TaskTableViewCell")
    }
    
    func fatchinDataFormApi(){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let sesion = URLSession(configuration: .default)
        
        var dataTask = sesion.dataTask(with: request) {data, responce, error in
            print("data\(data)")
            print("responce\(responce)")
            
            var getJSONObject = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            
            for dictionary in getJSONObject{
                let eachDictionary = dictionary as! [String:Any]
                
                let uid = eachDictionary["id"] as! Int
                let utitle = eachDictionary["title"] as! String
                let ubody = eachDictionary["body"] as! String
                
                var newPost = pods(id: uid, title: utitle, body: ubody)
                self.post.append(newPost)
            }
            DispatchQueue.main.async {
                self.tableViewToDisplayPods.reloadData()
            }
        }
        dataTask.resume()
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewToDisplayPods.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as! TaskTableViewCell
        cell.LabelId.text = String(post[indexPath.row].id)
        cell.LabelTitle.text = String(post[indexPath.row].title)
        cell.LabelBody.text = post[indexPath.row].body
        return cell
    }
    
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

