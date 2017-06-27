//
//  ViewController.swift
//  sampleMiniGuidebook
//
//  Created by 那須真 on 2017/06/19.
//  Copyright © 2017年 Makoto Nasu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView: UITableView!

    // プロパティリストから読み込んだdataを格納する配列
    // [string] -> 中身がstring型のデータが入っている配列
    var placeList:[String] = []
    
    var selectName = ""
    
    // TODO:2枚目の画面を作成し、タップされたエリア名を2枚目の画面で表示する（ラベル仕様）
    // エリア名をそのまま2枚目の画面に渡す（数字ではなく文字）

    override func viewDidLoad() {
        super.viewDidLoad()
        // プロパティリストファイルパス取得
        let filePath = Bundle.main.path(forResource: "placelist", ofType: "plist")
        
        // プロパティリストからdataを取得（ディクショナリー型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        // Tableviewで扱いやすい配列（エリアの入っている配列）を作成
        // 高速列挙で（for文）で値を取得
        for (key,data) in dic! {
//            print("KEY=\(key)")
//            print("DATA-\(data)")
            placeList.append(key as! String)
        }
        
        // printで配列の中身を確認（念のため）
        print(placeList)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    // ③リクエストに表示する文字列を決定し、表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 文字を表示するセルの取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // 表示したい文字の設定
        cell.textLabel?.text = placeList[indexPath.row] as String
        cell.accessoryType = .disclosureIndicator
        
        // 文字を設定さいたセルを返す
        return cell
        
        
    }
    
    
    //セルがタップ（選択）されたとき発動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("選択されたデータ:\(placeList[indexPath.row])")
        
        //選択されたエリア名をメンバ変数に格納
        selectName = placeList[indexPath.row]
        
        //セグエを指定して画面移動
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    // セグエを通って次の画面へ移動するとき
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 移動先の画面のインスタンスを作成
        var dvc = segue.destination as! second
            
        // 移動先の画面のプロパティにエリア名を指定
        // dvc.myLalel.text = selectName 考え方はOKだが、インスタンス化されるタイミングがもっと後なのでエラーになってしまう
        dvc.areaName = selectName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

