# MemeCreator
SwiftTutorials -  #1 JSON Parsing Example

![alt text](https://github.com/berkbirkan/MemeCreator2021-JSON-Parsing-Example/blob/main/Screenshot%20at%20Oct%2022%2018-19-37.png "JSON Parsing in Swift Example")


## Example JSON Structure

```
{
  "count": 2,
  "memes": [
    {
      "postLink": "https://redd.it/yaftc7",
      "subreddit": "memes",
      "title": "of course i did",
      "url": "https://i.redd.it/exsi8mqmtav91.png",
      "nsfw": false,
      "spoiler": false,
      "author": "External_Asparagus10",
      "ups": 471,
      "preview": [
        "https://preview.redd.it/exsi8mqmtav91.png?width=108&crop=smart&auto=webp&s=92eed21766acd635d79714ece136c04d280be1c9",
        "https://preview.redd.it/exsi8mqmtav91.png?width=216&crop=smart&auto=webp&s=079cc9f4324ed637dd3f9d44d2d61d51ad6fd48d",
        "https://preview.redd.it/exsi8mqmtav91.png?width=320&crop=smart&auto=webp&s=b697d8bc2c2b76d9770b4d9bfa0d6b6381960430",
        "https://preview.redd.it/exsi8mqmtav91.png?width=640&crop=smart&auto=webp&s=68ed95ec6715aed2079d7c57103bb4dee081eb72"
      ]
    },
    {
      "postLink": "https://redd.it/yaojgr",
      "subreddit": "memes",
      "title": "Goodbye, old friend",
      "url": "https://i.redd.it/77p8z16k5dv91.png",
      "nsfw": false,
      "spoiler": false,
      "author": "andreidg97",
      "ups": 41,
      "preview": [
        "https://preview.redd.it/77p8z16k5dv91.png?width=108&crop=smart&auto=webp&s=0becb156950b87ed63c881014210b122f8fa3a57",
        "https://preview.redd.it/77p8z16k5dv91.png?width=216&crop=smart&auto=webp&s=4f10d1aa867f4dfd533e7c6b1dd161e0d8c50371",
        "https://preview.redd.it/77p8z16k5dv91.png?width=320&crop=smart&auto=webp&s=db3455766e86a05834e48f79e25d29d371346b99",
        "https://preview.redd.it/77p8z16k5dv91.png?width=640&crop=smart&auto=webp&s=cde0d92ac5975e7b7e1be1078b28674908ee174d"
      ]
    }
  ]
}

 ```


# Parsing JSON Data with Swift 


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

