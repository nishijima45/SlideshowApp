//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 西嶋 信吾 on 2018/05/10.
//  Copyright © 2018年 西嶋 信吾. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let images = ["number1.png", "number2.png",  "number3.png"]
   
    var count: Int = 0
    
    
//    UIImage(name: imageName)
//    zoom.image = UIImage(string: imageName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        // 遷移先のResultViewControllerで宣言しているtextFieldに値を代入して渡す
        
        if let zoom = self.zoom.image{
            resultViewController.image = zoom
        }
        
        
    }
    @IBAction func go(_ sender: Any) {
        count += 1
        
        if count > images.count-1 {
            count = 0
        }
        let imageName = images[count]
        zoom.image = UIImage(named: imageName)
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        count -= 1
        
        if count < 0 {
            count = images.count-1
        }
        let imageName = images[count]
        zoom.image = UIImage(named: imageName)
    }

    @IBAction func playOrStop(_ sender: Any) {
        if self.timer == nil {
           startTimer()
        } else {
            pauseTimer()
        }
    }
    
    @IBOutlet weak var zoom: UIImageView!

    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    var timer: Timer!
    
    
    // selector: #selector(updatetimer) で指定された関数
    // timeInterval: 0.1, repeats: true で指定された通り、0.1秒毎に呼び出され続ける
    @objc func updateImage(timer: Timer) {
        count += 1
        
        if count > images.count-1 {
            count = 0
        }
        let imageName = images[count]
        zoom.image = UIImage(named: imageName)
        
    }
    
    
     func startTimer() {
        // 再生ボタンを押すとタイマー作成、始動
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
       
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true)
            
        print(timer_sec)
    }
    
    
     func pauseTimer() {
        // タイマーを破棄
        print(timer_sec)
            self.timer.invalidate()   // 現在のタイマーを破棄する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
        
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        // リセットボタンを押すと、タイマーの時間を0に
        self.timer_sec = 0
//        self.timerLabel.text = String(format: "%.1f", self.timer_sec)
        
        if self.timer != nil {
            self.timer.invalidate()   // 現在のタイマーを破棄する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
        }
    }
    
}

