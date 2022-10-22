//
//  RandomMemeViewController.swift
//  MemeCreator
//
//  Created by berk on 15.03.2021.
//

import UIKit
import SDWebImage
import MarqueeLabel

class RandomMemeViewController: UIViewController {
    @IBOutlet weak var textlabel: MarqueeLabel!
    
    @IBAction func share(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: [self.image.image], applicationActivities: nil)

        self.present(activityController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func makememe(_ sender: Any) {
        
       
        guard let url = URL(string: "https://meme-api.herokuapp.com/gimme/2") else {return}
        
    
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                       dataResponse, options: [])
                print(jsonResponse) //Response result
                
                
                guard let jsonArray = jsonResponse as? [String:Any] else {
                      return
                }
                print(jsonArray)
                
                var memes = jsonArray["memes"] as! [[String:Any]]
                var image = memes[0]["url"] as! String
                var title = memes[0]["title"] as! String
                
                DispatchQueue.main.async {
                    self.textlabel.text = title
                    self.image.sd_setImage(with: URL(string: image))
                   // self.image.downloaded(from: URL(string: image)!)
                    
                }
                
                
                
                
                
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
        
    }
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
