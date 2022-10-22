//
//  MakeMemeViewController.swift
//  MemeCreator
//
//  Created by berk on 13.03.2021.
//

import UIKit

class MakeMemeViewController: UIViewController {
    
    
   
    
    
    @IBAction func download(_ sender: Any) {
        
       

        let activityController = UIActivityViewController(activityItems: [image.image], applicationActivities: nil)

        self.present(activityController, animated: true, completion: nil)
    }
    
    var meme = String()
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var toptext: UITextView!
    
    
    @IBOutlet weak var bottomtext: UITextView!
    
    @IBAction func makememe(_ sender: Any) {
        
        var headers = ["x-rapidapi-key":"7f6474e309msh5b8eaaa848fe792p1935edjsna674f436b9fb","x-rapidapi-host":"ronreiter-meme-generator.p.rapidapi.com","useQueryString":true] as [String : Any]
        
        guard let url = URL(string: "https://ronreiter-meme-generator.p.rapidapi.com/meme?meme=" + meme + "&bottom=" + bottomtext.text! + "&top=" + toptext.text! + "&font_size=50&font=Impact") else {return}
        
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
                var newimage = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.image.image = newimage
                }
               
                
                
                
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = meme

        // Do any additional setup after loading the view.
    }
    
    
    

   

}
