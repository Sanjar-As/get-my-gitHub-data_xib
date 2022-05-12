import UIKit
import SwiftUI
import Combine
import Foundation

class ViewController: UIViewController {
    @Published var user: Datas? = nil
    
    @IBOutlet var uImage: UIImageView!
    @IBOutlet var uName: UILabel!
    @IBOutlet var uBio: UILabel!
    
    @IBOutlet var uFollowers: UILabel!
    @IBOutlet var uFollowing: UILabel!
    @IBOutlet var uCompany: UILabel!
    @IBOutlet var uLocation: UILabel!
    @IBOutlet var uApply: UILabel!
    @IBOutlet var uEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initViews()
    }
    
    // MARK: - Methods
    
    func initViews() {
        loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "https://api.github.com/users/Sanjar-As") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let data = data else {  return  }
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(Datas.self, from: data)
                
                DispatchQueue.main.async {
                    self.user = response
                    self.getUserData()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    //    UIImage(named: user.avatar_url)
    
    func getUserData() {
        if let user = self.user {
            let url = NSURL(string: user.avatar_url)
            let imagedata = NSData.init(contentsOf: url! as URL)
            if imagedata != nil {
                self.uImage.image = UIImage(data: imagedata! as Data)
            }
            
            self.uName.text = user.name
            self.uBio.text = user.bio
            
            self.uFollowers.text = String(user.followers)
            self.uFollowing.text = String(user.following)
            self.uCompany.text = user.company
            self.uLocation.text = user.location
            self.uApply.text = user.blog
            self.uEmail.text = user.email ?? "not assigned !!"
        } else {
            print("Data is missing(")
        }
    }
    
}
