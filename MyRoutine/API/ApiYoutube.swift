//
//  ApiYoutube.swift
//  MyRoutine
//
//  Created by Rafael on 1/15/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation

class ApiYoutube {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([ExercisesWger]?, String) -> ()
    
    var exercises: [ExercisesWger] = []
    var errorMessage = ""
    
    // TODO
    
    func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
        // TODO
        DispatchQueue.main.async {
            completion(self.exercises, self.errorMessage)
        }
    }
    
    fileprivate func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        exercises.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        var index = 0
        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary,

                let name_original = trackDictionary["name_original"] as? String {
                exercises.append(ExercisesWger(name_original:name_original))
                index += 1
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
    
}

/**

func updateSearchResults(_ data: Data) {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([ExercisesWger]?, String) -> ()
    
    var exercises: [ExercisesWger] = []
    var errorMessage = ""
    
    // 1
    let defaultSession = URLSession(configuration: .default)
    // 2
    var response: JSONDictionary?
    exercises.removeAll()
    
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
            
            let name_original = trackDictionary["name_original"] as? String {
            //tracks.append(Track(etag: etag,snippet: snippet as! [String : AnyObject],id: id  as! [String : AnyObject]))
            exercises.append(ExercisesWger(name_original:name_original))
            
            print(name_original)
        
            downloadPicTask.resume()
            
            index += 1
        } else {
            errorMessage += "Problem parsing trackDictionary\n"
        }
    }*/



/**func getTopVideos(nextPageToken : String, showLoader : Bool, completion:(_ videosArray : Array<Dictionary<NSObject, AnyObject>>, _ succses : Bool, _ nextpageToken : String)-> Void){
    
    
    
    
    
    //load Indicator
    
    if #available(iOS 9.0, *) {
        
        Alamofire.Manager.sharedInstance.session.getAllTasksWithCompletionHandler { (response) in
            
            response.forEach { $0.cancel() }
            
        }
        
    } else {
        
        // Fallback on earlier versions
        
        Alamofire.Manager.sharedInstance.session.getTasksWithCompletionHandler({ (dataTasks, uploadTasks, downloadTasks) in
            
            dataTasks.forEach { $0.cancel() }
            
            uploadTasks.forEach { $0.cancel() }
            
            downloadTasks.forEach { $0.cancel() }
            
        })
        
    }
    
    
    
    let contryCode = self.getCountryCode()
    
    var arrVideo: Array<Dictionary<NSObject, AnyObject>> = []
    
    var strURL = "https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&chart=mostPopular&maxResults=50®ionCode=\(contryCode)&key=\(API_KEY)"
    
    
    
    
    
    strURL = strURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    
    
    
    Alamofire.request(.GET, NSURL(string: strURL)!, parameters: nil, encoding: .URL, headers: nil).responseJSON(completionHandler: { (responseData) -> Void in
        
        
        
        
        
        let isSuccess = responseData.result.isSuccess//JSON(responseData.result.isSuccess)
        
        if isSuccess {
            
            
            
            let resultsDict = responseData.result.value as! Dictionary<NSObject, AnyObject>
            
            
            
            
            
            let items: Array<Dictionary<NSObject, AnyObject>> = resultsDict["items"] as! Array<Dictionary<NSObject, AnyObject>>
            
            
            
            for i in 0..<items.count {
                
                
                
                let snippetDict = items[i]["snippet"] as! Dictionary<NSObject, AnyObject>
                
                if !snippetDict["title"]! .isEqualToString("Private video") && !snippetDict["title"]! .isEqualToString("Deleted video"){
                    
                    let statisticsDict = items[i]["statistics"] as! Dictionary<NSObject, AnyObject>
                    
                    
                    
                    var videoDetailsDict = Dictionary<NSObject, AnyObject>()
                    
                    videoDetailsDict["videoTitle"] = snippetDict["title"]
                    
                    videoDetailsDict["videoSubTitle"] = snippetDict["channelTitle"]
                    
                    videoDetailsDict["channelId"] = snippetDict["channelId"]
                    
                    videoDetailsDict["imageUrl"] = ((snippetDict["thumbnails"] as! Dictionary<NSObject, AnyObject>)["high"] as! Dictionary<NSObject, AnyObject>)["url"]
                    
                    videoDetailsDict["videoId"] = items[i]["id"] as! String//PVideoViewCount
                    
                    videoDetailsDict["viewCount"] = statisticsDict["viewCount"]
                    
                    arrVideo.append(videoDetailsDict)
                    
                }
                
            }
            
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                completion(videosArray: arrVideo, succses: true,nextpageToken: self.strNextPageToken)
                
            })
            
        } else {
            
            
            
        }
        
    })
    
}*/
