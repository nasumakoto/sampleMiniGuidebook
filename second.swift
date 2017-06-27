//
//  second.swift
//  sampleMiniGuidebook
//
//  Created by 那須真 on 2017/06/19.
//  Copyright © 2017年 Makoto Nasu. All rights reserved.
//

import UIKit
import MapKit

class second: UIViewController {

    @IBOutlet weak var myTaxtView: UITextView!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    var areaName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let filePath = Bundle.main.path(forResource: "placelist", ofType: "plist")
        
        // プロパティリストからdataを取得（ディクショナリー型）だよね
        let dic = NSDictionary(contentsOfFile: filePath!)
      
        // 指定されたエリア名をキーにして、画面に必要な情報を取得
        
        let detailInfo:NSDictionary = dic![areaName] as! NSDictionary
        
        myTaxtView.text = (detailInfo["description"] as! String)
        myImageView.image = UIImage(named:detailInfo["image"] as! String)
        
        print(detailInfo["image"] as! String)
        print(detailInfo["description"] as! String)
        
        // 中心となる場所の座標オブジェクトを作成
        
        let coodinate = CLLocationCoordinate2DMake((Double(detailInfo["latitude"] as! String))!,(Double(detailInfo["longitude"] as! String)!))

        
        // 縮尺を設定
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        // 範囲オブジェクトを作成
        
        let region = MKCoordinateRegionMake(coodinate,span)
        
        // MapViewに周囲オブジェクトを設定
        myMapView.setRegion(region, animated:true)
        // アヤラにピンを立てる
        // ピンを生成
        
        let myPin = MKPointAnnotation()
        
        // ピンの座標を設定
        
        myPin.coordinate = coodinate
        //            myPin.coordinate = CLLocationCoordinate2DMake(10.317347,123.905759)
        
        // タイトル、サブタイトルを設定
        
        myPin.title = areaName
        myPin.subtitle = (detailInfo["description"] as! String)


        // mapViewにピンを追加
        
        myMapView.addAnnotation(myPin)
    
    }
    
    
    // ツールバーのアクションボタンがおされたとき

    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
        
        // アクティビティビューのインスタンスを作成
        let controller = UIActivityViewController(activityItems:[myImageView.image!],applicationActivities: nil)
        
        // モーダル表示
        self.present(controller,animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
