//
//  KindsViewController.swift
//  koebito
//
//  Created by Kazuhiro Watanabe on 2017/07/16.
//  Copyright © 2017年 Zombieges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KindsViewController: UIViewController {

    final private let viewModel = KindsViewModel()
    @IBOutlet weak var kindsDetailCollectionView: UICollectionView!
    var images: [Kinds] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set viewFrameWidth
        viewFrameWidth = self.view.frame.size.width
        
        // collectionViewSetting
        let nib = UINib(nibName: "KindCollectionViewCell", bundle: nil)
        self.kindsDetailCollectionView.register(nib, forCellWithReuseIdentifier: "KindCellIdentifier")
        
        // get image's name from enum
        images = Kinds.cases
        
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
}

extension KindsViewController: UICollectionViewDataSource,
                               UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // Cell はストーリーボードで設定したセルのID
        let KindCell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "KindCellIdentifier", for: indexPath)
        
        // Tag番号にてImageViewのインスタンス生成
        let imageView = KindCell.contentView.viewWithTag(1) as! UIImageView
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        
        // get Kind type
        let kindType = Kinds(rawValue: (indexPath as NSIndexPath).row)
        
        // set image fron enum
        let cellImage = kindType?.image
        
        // UIImageをUIImageViewのimageとして設定
        imageView.image = cellImage
        imageView.sizeToFit()
        
        // Tag番号を使ってLabelのインスタンス生成
        let label = KindCell.contentView.viewWithTag(2) as! UILabel
        label.text = kindType?.KindName

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
        return Kinds.cases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let kind = Kinds(rawValue: (indexPath as NSIndexPath).row) else {
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
