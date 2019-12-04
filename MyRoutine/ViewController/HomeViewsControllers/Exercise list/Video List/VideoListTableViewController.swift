//
//  VideoListTableViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/14/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import Siesta

class VideoListTableViewController: UITableViewController {
    
    
    var loadedExerciseName = String()
    var videoURL = String()
    
    private var arrayOfVideos: [String] = []
    private var arrayOfImages: [UIImage] = []
    private var arrayOfVideosId: [String] = []
    

    let queryService = QueryService()
    
    //Wheel spinner
    var activityIndicatorView: UIActivityIndicatorView!
    var rows: [String]?
    let dispatchQueue = DispatchQueue(label: "Example Queue")
    
    override func loadView() {
        super.loadView()
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView.backgroundView = activityIndicatorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Video List"
        
        typealias JSONDictionary = [String: Any]
        typealias QueryResult = ([Track]?, String) -> ()
        
        var tracks: [Track] = []
        var errorMessage = ""
        
        // 1
        let defaultSession = URLSession(configuration: .default)
        // 2
        var dataTask: URLSessionDataTask?
        

        
        func updateSearchResults(_ data: Data) {
            var response: JSONDictionary?
            tracks.removeAll()
            
            do {
                response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary

            } catch let parseError as NSError {
                errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                return
            }
            
            guard let array = response!["items"] as? [Any] else {
                errorMessage += "Dictionary does not contain results key\n"
                return
            }
            var index = 0
            for trackDictionary in array {
                
                if let trackDictionary = trackDictionary as? JSONDictionary,

                    let etag = trackDictionary["etag"] as? String,
                    let id = trackDictionary["id"],

                    let snippet = trackDictionary["snippet"] {
                    tracks.append(Track(etag: etag,snippet: snippet as! [String : AnyObject],id: id  as! [String : AnyObject]))
                    
                    for (key, value) in id as! [String : AnyObject]{
                        if(key=="videoId"){
                            arrayOfVideosId.append(value as! String)
                        }
                       
                    }
                    for (key, value) in snippet as! [String : AnyObject]{
                        if(key=="title"){
                            arrayOfVideos.append(value as! String)
                        }
                        if(key=="thumbnails"){
                            for dict in value as! [String : [String : AnyObject]]{
                                for urls in dict.value{
                                    if(urls.key == "url"){
                                        //arrayOfUrls.append(urls.value as! String)
                                        //print(urls.value)

                                        //https://www.freeiconspng.com/uploads/no-image-icon-6.png
                                        let catPictureURL = URL(string: urls.value as! String)!
                                        let session = URLSession(configuration: .default)
                                        let startDate = Date()
                                        let executionTime = Date().timeIntervalSince(startDate)
                                 
                                        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                                            if let e = error {
                                                print("Error downloading cat picture: \(e)")
                                            } else {
                                                if let res = response as? HTTPURLResponse {
                                                    print("Downloaded cat picture with response code \(res.statusCode)")
                                                    if let imageData = data {
                                                        let image = UIImage(data: imageData)
                                                        if(image != nil){
                                                            //print(image)
                                                            print(executionTime)
                                                            self.arrayOfImages.append(image!)
                                                        }
                                                        
                                                        // Do something with your image.
                                                    } else {
                                                        print("Couldn't get image: Image is nil")
                                                    }
                                                } else {
                                                    print("Couldn't get response code for some reason")
                                                }
                                            }
                                        }
                                        downloadPicTask.resume()
                                    }
                                    //
                                }//
                            }
                        }
                    }
                    

                    index += 1
                } else {
                    errorMessage += "Problem parsing trackDictionary\n"
                }
            }
        }
        
        queryService.getSearchResults(UrlString: "https://www.googleapis.com/youtube/v3/search?",queryPart: "part=snippet&q=\(loadedExerciseName)&type=video&key=AIzaSyAcI8Tb5nOGhOEPaxbfDwoyP1bauoaZgAQ", updateFunction:updateSearchResults){ results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.tableView.reloadData()
        }


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (rows == nil) {
            activityIndicatorView.startAnimating()
            
            tableView.separatorStyle = .none
            
            dispatchQueue.async {
                Thread.sleep(forTimeInterval: 3)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// MARK: - UITableViewDataSource
extension VideoListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfVideos.count //videos.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath)

        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width*0.5
        tableView.rowHeight = screenHeight/CGFloat(arrayOfVideos.count)
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width * 0.5, height: tableView.rowHeight))
        imgView.backgroundColor = UIColor.clear
        imgView.layer.cornerRadius = 8.0
        imgView.layer.masksToBounds = true

        if(arrayOfImages.count <= indexPath.row){
            imgView.image = UIImage(named: "Placeholder")
        }else if(arrayOfImages.count == 0){
            imgView.image = UIImage(named: "Placeholder")
        }else{
            imgView.image = arrayOfImages[indexPath.row]
        }
        
        let label = UILabel()
        label.frame = CGRect(x: screenWidth, y:0, width:imgView.frame.width , height:imgView.frame.height)
        if(arrayOfVideos.count >= indexPath.row){
            label.text = arrayOfVideos[indexPath.row]
        }
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-small", size: CGFloat(15))
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        
        
        cell.contentView.addSubview(imgView)
        cell.contentView.addSubview(label)
        
        cell.layer.borderWidth = 0.5
        let gray = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        cell.layer.borderColor = gray.cgColor
        
        return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        videoURL = arrayOfVideosId[indexPath.row]
        performSegue(withIdentifier: "goToVideoPlayerSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToVideoPlayerSegue", let LoadedVideo = segue.destination as? PlayerViewController  {
            LoadedVideo.loadedVideoUrl = videoURL
            
        }
    }
}

