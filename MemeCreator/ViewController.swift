//
//  ViewController.swift
//  MemeCreator
//
//  Created by berk on 12.03.2021.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var memes = [String]()
    var index = 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = memes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        self.performSegue(withIdentifier: "tomakememe", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondvc = segue.destination as! MakeMemeViewController
        secondvc.meme = memes[index]
    }
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        getMemes()
        
    }
    
    func getMemes(){
        
        var headers = ["x-rapidapi-key":"7f6474e309msh5b8eaaa848fe792p1935edjsna674f436b9fb","x-rapidapi-host":"ronreiter-meme-generator.p.rapidapi.com","useQueryString":true] as [String : Any]
        
        guard let url = URL(string: "https://ronreiter-meme-generator.p.rapidapi.com/images") else {return}
        
        var request = URLRequest(url: url)
        
        request.addValue("7f6474e309msh5b8eaaa848fe792p1935edjsna674f436b9fb", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("ronreiter-meme-generator.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue("true", forHTTPHeaderField: "useQueryString")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                       dataResponse, options: [])
                print(jsonResponse) //Response result
                
                
                guard let jsonArray = jsonResponse as? [String] else {
                      return
                }
                print(jsonArray)
                
                self.memes = jsonArray
                
                
                
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
        
    }


}

