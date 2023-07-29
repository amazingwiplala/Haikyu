//
//  GameViewController.swift
//  Haikyu
//
//  Created by Jeanine Chuang on 2023/7/24.
//

import UIKit

class GameViewController: UIViewController {
    var indexL = 0
    var indexR = 0
    
    @IBOutlet weak var ReportLabel: UILabel!
    
    @IBOutlet weak var LTeamView: UIView!
    @IBOutlet weak var RTeamView: UIView!
    
    @IBOutlet weak var LTeamPlayer: UIImageView!
    @IBOutlet weak var RTeamPlayer: UIImageView!
    
    @IBOutlet weak var LTeamLabel: UILabel!
    @IBOutlet weak var RTeamLabel: UILabel!

    @IBOutlet weak var LTeamLogo: UIImageView!
    @IBOutlet weak var RTeamLogo: UIImageView!
    
    @IBOutlet weak var LSetScore: UILabel!
    @IBOutlet weak var RSetScore: UILabel!
    
    @IBOutlet weak var LScore: UILabel!
    @IBOutlet weak var RScore: UILabel!
    
    @IBOutlet weak var LTeamVollyball: UIButton!
    @IBOutlet weak var RTeamVollyball: UIButton!
    
    @IBOutlet weak var WinnerView: UIView!
    @IBOutlet weak var WinnerImageView: UIImageView!
    @IBOutlet weak var CloseWinnerButton: UIButton!
    
    @IBOutlet weak var CrownL: UIButton!
    @IBOutlet weak var CrownR: UIButton!
    
    @IBOutlet weak var WinnerLLabel: UILabel!
    @IBOutlet weak var WinnerRLabel: UILabel!
    
    @IBOutlet weak var WinnerLSetScore: UILabel!
    @IBOutlet weak var WinnerRSetScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the
        
        initGameUI()
        
    }
    
    //back to team
    @IBAction func backToTeam(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //初始化
    func initGameUI(){
        
        //左隊
        indexL = indexA
        LTeamLabel.text = teams[indexL]
        LTeamView.backgroundColor = teamColors[indexL]
        LTeamLogo.image = UIImage(named: teams[indexL] + "-logo")
        LSetScore.text = "0"
        LScore.text = "0"
        
        //右隊
        indexR = indexB
        RTeamLabel.text = teams[indexR]
        RTeamView.backgroundColor = teamColors[indexR]
        RTeamLogo.image = UIImage(named: teams[indexR] + "-logo")
        RSetScore.text = "0"
        RScore.text = "0"
        
        //發球隊
        let serve = Bool.random()
        LTeamVollyball.isHidden = serve
        RTeamVollyball.isHidden = !serve
        
        //勝利隊伍
        WinnerView.isHidden = true
        
    }
    
    var SetCount:Int = 1
    var LTouchBallCount:Int = 0
    var RTouchBallCount:Int = 0
    
    //接發球 - 右隊
    func RReceive(){
        
        //觸球+1
        RTouchBallCount = RTouchBallCount + 1
        
        //接發成功 & 觸球3次內
        if Bool.random() && RTouchBallCount<3 {
            ReportLabel.text = teams[indexR] + "第\(RTouchBallCount)次接球成功"
            //打過網
            if Bool.random(){
                ReportLabel.text = teams[indexR] + "殺球過網"
                RTouchBallCount = 0 //觸球歸零
                //左隊接發準備
                LPrepare()
            }
            
        //失敗
        }else{
            ReportLabel.text = teams[indexR] + "失分"
            //左隊得分
            AddLScore()
        }
    }
    
    //接發球 - 左隊
    func LReceive(){
        
        //觸球+1
        LTouchBallCount = LTouchBallCount + 1
        
        //接發成功 & 觸球3次內
        if Bool.random() && LTouchBallCount<3 {
            ReportLabel.text = teams[indexL] + "第\(LTouchBallCount)次接球成功"
            //打過網
            if Bool.random(){
                ReportLabel.text = teams[indexL] + "殺球過網"
                LTouchBallCount = 0 //觸球歸零
                //右隊接發準備
                RPrepare()
            }
            
            //失敗
        }else{
            ReportLabel.text = teams[indexL] + "失分"
            //右隊得分
            AddRScore()
        }
    }
    
    //右隊接發準備
    func RPrepare(){
        //隱藏左隊
        LTeamVollyball.isHidden = true
        LTouchBallCount = 0
        
        //顯示右隊
        RTeamVollyball.isHidden = false
        RTouchBallCount = 0
    }
    //左隊接發準備
    func LPrepare(){
        //隱藏右隊
        RTeamVollyball.isHidden = true
        RTouchBallCount = 0
        
        //顯示左隊
        LTeamVollyball.isHidden = false
        LTouchBallCount = 0
    }
    //下一回合
    func nextSetPrepare(){
        SetCount += 1
        LScore.text = "0"
        RScore.text = "0"
        switchCourt() //換場
    }
    
    //換場
    func switchCourt(){
        //左隊 -> temp
        let indexTemp:Int = indexL
        let scoreTemp:String = LScore.text ?? "0"
        let setScoreTemp:String = LSetScore.text ?? "0"
        
        //右隊 -> 左隊
        indexL = indexR
        LScore.text = RScore.text
        LSetScore.text = RSetScore.text
        
        //temp -> 右隊
        indexR = indexTemp
        RScore.text = scoreTemp
        RSetScore.text = setScoreTemp
        
        //隊名及場地
        LTeamLabel.text = teams[indexL]
        LTeamView.backgroundColor = teamColors[indexL]
        RTeamLabel.text = teams[indexR]
        RTeamView.backgroundColor = teamColors[indexR]
        
        //發球隊
        let serve = Bool.random()
        LTeamVollyball.isHidden = serve
        RTeamVollyball.isHidden = !serve
        
        ReportLabel.text = ""
    }
    
    //右隊得分
    func AddRScore(){
        let rScore:Int = (Int(RScore.text ?? "0") ?? 0) + 1
        RScore.text = String(rScore)
        
        //回合結束
        if setWinner() {
            
            //比賽結束
            if finalWinner() {
                //恭喜獲勝隊伍
                gameAlert(index: indexR)
            //比賽尚未結束
            }else{
                //下一回合
                setAlert(team: teams[indexR])
            }
            
        //回合尚未結束
        }else{
            RPrepare()  //得分隊發球
        }
    }
    
    //左隊得分
    func AddLScore(){
        let lScore:Int = (Int(LScore.text ?? "0") ?? 0) + 1
        LScore.text = String(lScore)
        
        //回合結束
        if setWinner() {
            //比賽結束
            if finalWinner() {
                //恭喜獲勝隊伍
                gameAlert(index: indexL)
            //比賽尚未結束
            }else{
                //下一回合
                setAlert(team: teams[indexL])
            }
            
        //回合尚未結束
        }else{
            LPrepare()  //得分隊發球
        }
    }
    //右隊回合得分
    func AddRSetScore(){
        let rSetScore:Int = (Int(RSetScore.text ?? "0") ?? 0) + 1
        RSetScore.text = String(rSetScore)
    }
    //左隊回合得分
    func AddLSetScore(){
        let lSetScore:Int = (Int(LSetScore.text ?? "0") ?? 0) + 1
        LSetScore.text = String(lSetScore)
    }
    
    //判斷回合勝隊
    func setWinner() -> Bool {
        var isSetOver:Bool = true
        let lScore:Int = Int(LScore.text ?? "0") ?? 0
        let rScore:Int = Int(RScore.text ?? "0") ?? 0
        
        //左隊 取得回合
        if (lScore==15 && rScore<=13)           //左隊是否15分內取勝
            || (lScore>15 && lScore-rScore==2)  //左隊是否duce領先2分取勝
            || lScore==20   {                   //左隊是否duce達到20分取勝
            
            AddLSetScore()
           
        //右隊 取得回合
        }else if (rScore==15 && lScore<=13)     //右隊是否15分內取勝
            || (rScore>15 && rScore-lScore==2)  //右隊是否duce領先2分取勝
                    || rScore==20 {                     //右隊是否duce達到20分取勝
            
            AddRSetScore()
        
        //回合繼續
        }else{
            isSetOver = false
        }
        
        return isSetOver
    }
    
    //判斷賽末勝隊
    func finalWinner() -> Bool {
        var isGameOver:Bool = true
        let lSetScore:Int = Int(LSetScore.text ?? "0") ?? 0
        let rSetScore:Int = Int(RSetScore.text ?? "0") ?? 0
        
        //左隊 兩戰兩勝 三戰二勝
        if lSetScore==2 && rSetScore<=1{
            theWinnerIs(index: indexL)
            
        //右隊 兩戰兩勝 三戰二勝
        }else if rSetScore==2 && lSetScore<=1{
            theWinnerIs(index: indexR)
           
        //下一回合
        }else{
            isGameOver = false
        }
        
        return isGameOver
    }
    
    //恭喜勝利隊伍
    func theWinnerIs(index:Int){
        WinnerImageView.image = UIImage(named: "\(teams[index])-win")
        WinnerLLabel.text = LTeamLabel.text
        WinnerRLabel.text = RTeamLabel.text
        WinnerLSetScore.text = LSetScore.text
        WinnerRSetScore.text = RSetScore.text
        if teams[index]==WinnerLLabel.text {
            CrownL.isHidden = false
            CrownR.isHidden = true
        }else{
            CrownL.isHidden = true
            CrownR.isHidden = false
        }
        WinnerView.isHidden = false
    }
    
    //訊息 - 回合結束
    func setAlert(team:String) {
        let alertController = UIAlertController(title: "第\(SetCount)回合結束", message: "\(team)贏得第\(SetCount)回合", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "下一回合", style: .default, handler: { action in self.nextSetPrepare() })
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    //訊息 - 比賽結束
    func gameAlert(index:Int) {
        let alertController = UIAlertController(title: "比賽結束", message: "\(teams[index])贏得比賽", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "恭喜", style: .default, handler: { action in self.theWinnerIs(index: index) })
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    //左隊接球
    @IBAction func LTeamActionEnd(_ sender: Any) {
        
        //放開時球變回黃色
        LTeamVollyball.tintColor = UIColor.systemYellow
        
        //放開時隱藏球員
        LTeamPlayer.isHidden = true
        LReceive()
    }
    @IBAction func LTeamActionStart(_ sender: Any) {
        
        //按下時球變成粉紅色
        LTeamVollyball.tintColor = UIColor.systemPink
        
        //按下時顯示球員
        LTeamPlayer.image = UIImage(named: teams[indexL]+"-Q"+String(Int.random(in: 1...9)))
        LTeamPlayer.isHidden = false
    }
    
    //右隊接球
    @IBAction func RTeamActionEnd(_ sender: Any) {
        //放開時球變回黃色
        RTeamVollyball.tintColor = UIColor.systemYellow
        
        //放開時隱藏球員
        RTeamPlayer.isHidden = true
        RReceive()
    }
    @IBAction func RTeamActionStart(_ sender: Any) {
        //按下時球變成粉紅色
        RTeamVollyball.tintColor = UIColor.systemPink
        
        //按下時顯示球員
        RTeamPlayer.image = UIImage(named: teams[indexR]+"-Q"+String(Int.random(in: 1...9)))
        RTeamPlayer.isHidden = false
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
