//
//  WebViewController.swift
//  NetFlix2023
//
//  Created by Apple on 21/03/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController ,WKNavigationDelegate{
    
    @IBOutlet weak var myWebView: WKWebView!
    var urlstring = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        myWebView.navigationDelegate = self
        load()
    }
    
    func load(){
        if let url = URL(string: urlstring){
            let request = URLRequest(url: url)
            myWebView.load(request)
        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Failed to load webpage with error \(error.localizedDescription)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
