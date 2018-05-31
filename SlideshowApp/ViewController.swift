//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 西嶋 信吾 on 2018/05/10.
//  Copyright © 2018年 西嶋 信吾. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var susumu: UIButton!
    @IBOutlet weak var modoru: UIButton!
    @IBOutlet weak var zoom: UIImageView!
    
    var count: Int = 0
    var timer: Timer!
    
    let images = ["number1.png", "number2.png",  "number3.png"]
   
    func update() {
        count += 1
        if count > 2 {
            count = 0
        }
        let imageName = images[count]
        zoom.image = UIImage(named: imageName)
    }
    
    
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
        let resultViewController:ResultViewController? = segue.destination as? ResultViewController
        // 遷移先のResultViewControllerで宣言しているtextFieldに値を代入して渡す
        
        if let zoom = self.zoom.image {
            resultViewController?.image = zoom
        }
    }
    @IBAction func go(_ sender: Any) {
        update()
    }
    
    @IBAction func goBack(_ sender: Any) {
        count -= 1
        
        if count < 0 {
            count = images.count - 1
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

    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    // selector: #selector(updatetimer) で指定された関数
    // timeInterval: 0.1, repeats: true で指定された通り、0.1秒毎に呼び出され続ける
    @objc func updateImage(timer: Timer) {
        update()
    }
    
    func startTimer() {
        // 再生ボタンを押すとタイマー作成、始動
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true)
        button.setTitle("停止", for: [])
        // 進むと戻るボタン無効化
        susumu.isEnabled = false
        modoru.isEnabled = false
    }
    
     func pauseTimer() {
        // タイマーを破棄
        self.timer.invalidate()   // 現在のタイマーを破棄する
        self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
        button.setTitle("再生", for: [])
        susumu.isEnabled = true
        modoru.isEnabled = true
    }
}

