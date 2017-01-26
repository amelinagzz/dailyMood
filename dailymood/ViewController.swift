//
//  ViewController.swift
//  dailymood
//
//  Created by Adriana Gonzalez on 1/11/17.
//  Copyright © 2017 AMGM. All rights reserved.
//

import UIKit
import Crashlytics
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var moods : [Mood] = []
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self

        self.getMoods()
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "gotNewMood"), object: nil, queue: nil) { (notification) in
            DispatchQueue.main.async {
                self.moods = []
                self.getMoods()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func getMoods(){
        
        let moodsarray = realm.objects(Mood.self).sorted(byKeyPath: "date", ascending: false)
        
        for mood in moodsarray {
            let m = mood as Mood
            print(m.name)
            moods.append(m)
        }
        
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "moodCell", for: indexPath) as! MoodCell
        cell.nameLbl.text = moods[indexPath.row].name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy hh:mm"
        
        cell.dateLbl.text = dateFormatter.string(from: moods[indexPath.row].date as! Date)
        
        switch moods[indexPath.row].name {
        case "Happy":
            cell.img.image = UIImage(named: "happy")
        case "Nerdy":
            cell.img.image = UIImage(named: "nerd")
        case "Cool":
            cell.img.image = UIImage(named: "cool")
        case "Whatever":
            cell.img.image = UIImage(named: "whatever")
        case "Sad":
            cell.img.image = UIImage(named: "sad")
        case "Angry":
            cell.img.image = UIImage(named: "angry")

        default:
            cell.img.image = UIImage(named: "happy")

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

