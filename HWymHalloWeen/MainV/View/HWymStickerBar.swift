//
//  HWymStickerBar.swift
//  HWymHalloWeen
//
//  Created by JOJO on 2021/10/19.
//

import UIKit

enum HWymStickerType {
    case mask
    case headwear
}



class HWymStickerBar: UIView {
    var collection: UICollectionView!
    var stickerType: HWymStickerType
    var stickerList: [HWStickerItem] = []
    var currentItem: HWStickerItem?
    
    var stickerClickBlock: ((HWStickerItem)->Void)?
    
    
    init(frame: CGRect, type: HWymStickerType) {
        self.stickerType = type
        super.init(frame: frame)
        loadData()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        if self.stickerType == .mask {
            stickerList = DataManager.default.maskStickerList
        } else {
            stickerList = DataManager.default.headwearStickerList
            
        }
        
    }
    
    func setupView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
        collection.register(cellWithClass: HWymStickerCell.self)
    }
    

}

extension HWymStickerBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HWymStickerCell.self, for: indexPath)
        let item = stickerList[indexPath.item]
        cell.contentImgV.image(item.thumbName)
        if currentItem?.thumbName == item.thumbName {
            cell.selectBgView.isHidden = false
        } else {
            cell.selectBgView.isHidden = true
        }
        if item.isPro == true {
            cell.proImgV.isHidden = false
        } else {
            cell.proImgV.isHidden = true
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickerList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension HWymStickerBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
}

extension HWymStickerBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = stickerList[indexPath.item]
        currentItem = item
        collectionView.reloadData()
        stickerClickBlock?(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}



class HWymStickerCell: UICollectionViewCell {
    let bgView = UIView()
    let selectBgView = UIView()
    let contentImgV = UIImageView()
    let proImgV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        bgView
            .backgroundColor(UIColor(hexString: "#2B2A29")!)
            .adhere(toSuperview: contentView)
        bgView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(65)
        }
        bgView.layer.cornerRadius = 65/2
        //
        selectBgView
            .backgroundColor(UIColor.clear)
            .adhere(toSuperview: contentView)
        selectBgView.layer.cornerRadius = 65/2
        selectBgView.layer.borderColor = UIColor(hexString: "#EB6601")?.cgColor
        selectBgView.layer.borderWidth = 2
        selectBgView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(65)
        }
        
        
        //
        contentImgV.contentMode = .scaleAspectFit
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.center.equalTo(contentView)
            $0.width.height.equalTo(60)
        }
        //
        proImgV
            .image("pro_ic")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: contentView)
        proImgV.snp.makeConstraints {
            $0.top.right.equalTo(bgView)
            $0.width.height.equalTo(18)
        }
        
    }
}


