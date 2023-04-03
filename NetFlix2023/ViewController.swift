//
//  ViewController.swift
//  NetFlix2023
//
//  Created by Apple on 21/03/23.
//

import UIKit

var eData = [NetFlixApp]()
class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
    }
    func fetchData(){
        let url = URL(string: "https://gist.githubusercontent.com/forloop1989/e00971dc18a6e581533f8512cddd221e/raw/df1108595c3647c10c273b93fd3d1812438456b5/Movie.json")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error)in
            guard let data = data ,error == nil else{
                print("error occured")
                return
            }
            do{
                let netFlixData = try JSONSerialization.jsonObject(with: data)
                guard let netFlixData2 = netFlixData as? [ AnyHashable : Any] else
                {
                    return
                }
                guard let dictArray = netFlixData2["movieData"] as? [[AnyHashable : Any]] else {
                    return
                }
                for dict in dictArray{
                    // print(dict)
                    //  print(dict["category"])
                    //print(dict["movies"])
                    guard let moviecategory = dict["category"] as? String else{
                        return
                    }
                    guard let moviesList = dict["movies"] as? [[AnyHashable:Any]] else{
                        return
                    }
                    var movieobj = [Movie]()
                    for dictMovies in moviesList{
                        //print(dictMovies)
                        guard let movieDict = dictMovies as? [AnyHashable:Any] else{
                            return
                        }
                        print(movieDict["title"])
                        var newMovie = Movie(movieName: movieDict["title"] as! String, trailerUrl: movieDict["trailerUrl"] as! String)
                        newMovie.imageURLString = self.getYouTubeThumbnailUrl(videoUrl: newMovie.trailerUrl)
                        movieobj.append(newMovie)
                        print(newMovie.imageURLString)
                        
                    }
                    let movieDataObj = NetFlixApp(sectionType: moviecategory, movies: movieobj)
                    eData.append(movieDataObj)
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                }
                
            }
            catch{
                print("error occured\(error)")
            }
        })
        task.resume()
    }
    func getYouTubeThumbnailUrl(videoUrl:String) -> String {
        guard let urlForVideo = URL(string: videoUrl) else{
            return ""
        }
        let videoID = urlForVideo.lastPathComponent
        print(videoID)
        let newImageURL = "https://img.youtube.com/vi/\(videoID)/mqdefault.jpg"
        print(newImageURL)
        return newImageURL
    }
}







extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! MyTableViewCell
        cell.myCollectionView.tag = indexPath.section
        cell.navigationController = self.navigationController
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return eData.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eData[section].sectionType
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .cyan
    }
    
    
}


