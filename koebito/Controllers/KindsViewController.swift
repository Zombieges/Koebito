//
//  KindsViewController.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/07/16.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit

class KindsViewController: UIViewController {

    @IBOutlet weak var kindsDetailCollectionView: UICollectionView!
    let images = ["crying","love","sulk","mad","encourage"]
    let kindsString = ["泣いてる系","甘える系","拗ねてる系","怒ってる系","励まし系"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewFrameWidth = self.view.frame.size.width
        
        // collectionViewSetting
        let nib = UINib(nibName: "KindCollectionViewCell", bundle: nil)
        self.kindsDetailCollectionView.register(nib, forCellWithReuseIdentifier: "KindCellIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewDidLayoutSubviews() {
        if let viewFrameWidth = viewFrameWidth,
           let viewFrameHeight = viewFrameHeight {
            // coolectionView の width、height を設定
            self.kindsDetailCollectionView.frame = CGRect(x: 0, y: 0, width: viewFrameWidth, height: viewFrameHeight)
        }
    }
}

extension KindsViewController: UICollectionViewDataSource,
                               UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // Cell はストーリーボードで設定したセルのID
        let KindCell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "KindCellIdentifier", for: indexPath)
        
        // Tag番号にてImageViewのインスタンス生成
        let imageView = KindCell.contentView.viewWithTag(1) as! UIImageView
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        let cellImage = UIImage(named: images[(indexPath as NSIndexPath).row])
        // UIImageをUIImageViewのimageとして設定
        imageView.image = cellImage
        imageView.sizeToFit()
        
        
        // Tag番号を使ってLabelのインスタンス生成
        let label = KindCell.contentView.viewWithTag(2) as! UILabel
        label.text = kindsString[(indexPath as NSIndexPath).row]
        label.sizeToFit()
        
        //imageView.backgroundColor = UIColor.black
        if let displayIncellPosition = displayIncellPosition {
            imageView.layer.position = CGPoint(x: displayIncellPosition,y: displayIncellPosition)
            label.layer.position = CGPoint(x: displayIncellPosition, y: displayIncellPosition + 50.0)
        }
        
        
        // とりあえず適当に色をつけている（あとで変更する）
        KindCell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                           green: CGFloat(drand48()),
                                           blue: CGFloat(drand48()),
                                           alpha: 1.0)
        
        return KindCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "kindDetailSegue", sender: nil)
    }
}

extension KindsViewController: UICollectionViewDelegateFlowLayout {
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cellSize = cellSize else {
            return CGSize(width: 0, height: 0)
        }
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
}
