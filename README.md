# MemeCreator
SwiftTutorials -  #1 JSON Parsing Example

```
let url = URL(string: "https://meme-api.herokuapp.com/gimme/2") else {return}
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
        
        ```

