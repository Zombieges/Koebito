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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Kinds.crying)
        
        viewFrameWidth = self.view.frame.size.width
        
        // collectionViewSetting
        let nib = UINib(nibName: "KindCollectionViewCell", bundle: nil)
        self.kindsDetailCollectionView.register(nib, forCellWithReuseIdentifier: "KindCellIdentifier")
    }
    
    override func viewDidLayoutSubviews() {
        if let viewFrameWidth = viewFrameWidth,
           let viewFrameHeight = viewFrameHeight {
            // coolectionView の width、height を設定
            self.kindsDetailCollectionView.frame = CGRect(x: 0, y: 0, width: viewFrameWidth, height: viewFrameHeight)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! KindDetailViewController
        vc.kind = sender as! Kinds?
    }
    
    func getKind(rawValue: Int) -> Kinds? {
        switch rawValue {
        case 0:
            return Kinds.crying
        case 1:
            return Kinds.love
        case 2:
            return Kinds.sulk
        case 3:
            return Kinds.mad
        case 4:
            return Kinds.encourage
        default:
            return nil
        }
    }
    
    func getKindName(rawValue: Int) -> String? {
        switch rawValue {
        case 0:
            return Kinds.crying.KindName
        case 1:
            return Kinds.love.KindName
        case 2:
            return Kinds.sulk.KindName
        case 3:
            return Kinds.mad.KindName
        case 4:
            return Kinds.encourage.KindName
        default:
            return nil
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
        if let kindName = getKindName(rawValue: indexPath[1]) {
            label.text = kindName
        }
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
        guard let kind = getKind(rawValue: indexPath[1]) else {
            return
        }
        performSegue(withIdentifier: "kindDetailSegue", sender: kind)
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
