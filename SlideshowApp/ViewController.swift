//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 橋本　武 on 2021/07/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var startAndStopButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    //タイマー
    var timer: Timer!
    
    // タイマー用の時間のための変数
    var timer_sec: Float = 0
    
    //画像保持
    var imageArray:[UIImage] = [
        UIImage(named: "chara_jerry.png")!,
        UIImage(named: "chara_tom.png")!,
        UIImage(named: "tom&jerry.jpeg")!
    ]
        
    //imageArrayのIndex指定用変数
    var imageArrayIndex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // indexの画像をstoryboardの画像にセットする
        self.imageView.image = imageArray[self.imageArrayIndex]
        self.startAndStopButton.setTitle("再生", for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のImageViewControllerを取得する
        let imageViewController:ImageViewController = segue.destination as! ImageViewController
        // 遷移先のImageViewControllerで宣言しているimageに値を代入して渡す
        imageViewController.image = imageArray[self.imageArrayIndex]
    }

    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    @objc func changeNextImage() {
        // indexを増やして表示する画像を切り替える
        self.imageArrayIndex += 1

        // indexが表示予定の最後の画像の場合
        if (self.imageArrayIndex == imageArray.count) {
            // indexを一番最初の数字に戻す
            self.imageArrayIndex = 0
        }
        // indexの画像をstoryboardの画像にセットする
        self.imageView.image = imageArray[self.imageArrayIndex]
    }
    
    @objc func changeBackImage() {
        // indexを減らして表示する画像を切り替える
        self.imageArrayIndex -= 1

        // indexが表示予定の最初の画像の場合
        if (self.imageArrayIndex == -1) {
            // indexを最後の数字に戻す
            self.imageArrayIndex = imageArray.count - 1
        }
        // indexの画像をstoryboardの画像にセットする
        self.imageView.image = imageArray[self.imageArrayIndex]
    }
    
    @IBAction func imageButton(_ sender: Any) {
        if (timer != nil) {
            // タイマーを停止する
            self.timer.invalidate()

            // タイマーをnilにする
            self.timer = nil
 
            //進む/戻るボタンを活性
            self.nextButton.isEnabled = true
            self.backButton.isEnabled = true
            
            //ボタンの表示文字を変更
            self.startAndStopButton.setTitle("再生", for: .normal)

        }
    }

    @IBAction func nextImage(_ sender: Any) {
        changeNextImage()
    }
    
    @IBAction func backImage(_ sender: Any) {
        changeBackImage()
    }
    
    @IBAction func startAndStop(_ sender: Any) {
        // 再生中か停止しているかを判定
        if (timer == nil) {
            // タイマーをセットする
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeNextImage), userInfo: nil, repeats: true)
            
            //進む/戻るボタンを非活性
            self.nextButton.isEnabled = false
            self.backButton.isEnabled = false
            
            //ボタンの表示文字を変更
            self.startAndStopButton.setTitle("停止", for: .normal)
        } else {
            // タイマーを停止する
            self.timer.invalidate()

            // タイマーをnilにする
            self.timer = nil
            
            //進む/戻るボタンを活性
            self.nextButton.isEnabled = true
            self.backButton.isEnabled = true
            
            //ボタンの表示文字を変更
            self.startAndStopButton.setTitle("再生", for: .normal)
        }
    }
}

