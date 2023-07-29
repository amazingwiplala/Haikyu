//
//  ViewController.swift
//  Haikyu
//
//  Created by Jeanine Chuang on 2023/7/24.
//

import UIKit

var indexA = 0
var indexB = 0
let teams = ["烏野","音駒","青葉城西","伊達工業","梟谷學園","白鳥澤","稻荷崎"]
let teamColors = [
    UIColor(red: 220/255, green: 132/255, blue: 77/255, alpha: 1),
    UIColor(red: 217/255, green: 67/255, blue: 77/255, alpha: 1),
    UIColor(red: 148/255, green: 193/255, blue: 186/255, alpha: 1),
    UIColor(red: 76/255, green: 112/255, blue: 111/255, alpha: 1),
    UIColor(red: 156/255, green: 157/255, blue: 159/255, alpha: 1),
    UIColor(red: 121/255, green: 65/255, blue: 108/255, alpha: 1),
    UIColor(red: 125/255, green: 62/255, blue: 72/255, alpha: 1)
]


class ViewController: UIViewController {
    
    @IBOutlet weak var ATeamLabel: UILabel!
    @IBOutlet weak var BTeamLabel: UILabel!
    @IBOutlet weak var ATeamImageView: UIImageView!
    @IBOutlet weak var BTeamImageView: UIImageView!
    
    @IBOutlet weak var ATeamPageControl: UIPageControl!
    @IBOutlet weak var BTeamPageControl: UIPageControl!
    
    @IBOutlet weak var PlayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
    }
    //橫向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            .landscape
        }
    
    //initiate UI
    func initUI(){
        indexA = Int.random(in: 0...6)
        indexB = Int.random(in: 0...6)
        selectATeam()
        selectBTeam()
        
    }

    //左邊ImageView向右滑 >> 上一筆
    @IBAction func preATeam(_ sender: Any) {
        indexA = (indexA - 1 + teams.count) % teams.count
        selectATeam()
    }
    //左邊ImageView向左滑 >> 下一筆
    @IBAction func nextATeam(_ sender: Any) {
        indexA = (indexA + 1) % teams.count
        selectATeam()
    }
    //左邊Page Control 點選
    @IBAction func ATeamChangePage(_ sender: Any) {
        indexA = ATeamPageControl.currentPage
        selectATeam()
    }
    
    //右邊ImageView向右滑 >> 上一筆
    @IBAction func preBTeam(_ sender: Any) {
        indexB = (indexB - 1 + teams.count) % teams.count
        selectBTeam()
    }
    //右邊ImageView向左滑 >> 下一筆
    @IBAction func nextBTeam(_ sender: Any) {
        indexB = (indexB + 1) % teams.count
        selectBTeam()
    }
    //右邊Page Control 點選
    @IBAction func BTeamChangePage(_ sender: Any) {
        indexB = BTeamPageControl.currentPage
        selectBTeam()
    }
    
    //更新左邊隊伍內容 update when A Team selected
    func selectATeam(){
        ATeamLabel.text = teams[indexA]
        ATeamImageView.image = UIImage(named: teams[indexA])
        ATeamPageControl.currentPage = indexA
    }
    //更新右邊隊伍內容 update when B Team selected
    func selectBTeam(){
        BTeamLabel.text = teams[indexB]
        BTeamImageView.image = UIImage(named: teams[indexB])
        BTeamPageControl.currentPage = indexB
    }
    
    //檢查是否同隊
    func checkIfSameTeam(){
        if indexA==indexB {
            sameTeamAlert()
        }
    }
    
    //PLAY
    @IBAction func Play(_ sender: Any) {
        checkIfSameTeam() //檢查是否同隊
    }
    
    //訊息 - 檢查是否同隊
    func sameTeamAlert() {
        let alertController = UIAlertController(title: "注意", message: "無法同隊比賽，請選擇其他隊伍！", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
}

