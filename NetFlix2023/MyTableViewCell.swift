//
//  MyTableViewCell.swift
//  NetFlix2023
//
//  Created by Apple on 21/03/23.
//

import UIKit
import Kingfisher
class MyTableViewCell: UITableViewCell {
    var navigationController : UINavigationController?
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension MyTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = eData[myCollectionView.tag]
        let item = section.movies.count
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! MyCollectionViewCell
        let section = eData[myCollectionView.tag]
        let movie = section.movies[indexPath.row]
        let imagelink = movie.imageURLString
        if let imageUrl = imagelink , let url = URL(string: imageUrl)
        {
            cell.myImage.kf.setImage(with: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: .main)
        let vc = main.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let section = eData[myCollectionView.tag]
        let selectMovie = section.movies[indexPath.row]
        let selectMovieTrailerUrl = selectMovie.trailerUrl
        vc.urlstring = selectMovieTrailerUrl
        navigationController?.pushViewController(vc, animated: true)
    }
}
