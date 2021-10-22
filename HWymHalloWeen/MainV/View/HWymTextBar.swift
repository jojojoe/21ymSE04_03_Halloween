//
//  HWymTextBar.swift
//  HWymHalloWeen
//
//  Created by JOJO on 2021/10/19.
//

import UIKit


class HWymTextBar: UIView {
    var collection: UICollectionView!
    
    var colorList: [UIColor] = []
    var currentColorItem: UIColor?
    var colorClickBlock: ((UIColor)->Void)?
    var alightmenClickBlock: ((NSTextAlignment)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadData()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        colorList = DataManager.default.getColorData()
        
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
            $0.top.equalTo(snp.centerY).offset(0)
            $0.right.left.equalToSuperview()
            $0.height.equalTo(60)
        }
        collection.register(cellWithClass: HWymTextColorCell.self)
        
        //
        let leftBtn = UIButton(type: .custom)
        let centerBtn = UIButton(type: .custom)
        let rightBtn = UIButton(type: .custom)
        
        centerBtn
            .image("text_center_ic")
            .adhere(toSuperview: self)
        centerBtn.addTarget(self, action: #selector(centerBtnClick(sender: )), for: .touchUpInside)
        centerBtn.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.bottom.equalTo(self.snp.centerY).offset(-5)
            $0.centerX.equalToSuperview()
        }
        
        //
        leftBtn
            .image("text_left_ic")
            .adhere(toSuperview: self)
        leftBtn.addTarget(self, action: #selector(leftBtnClick(sender: )), for: .touchUpInside)
        leftBtn.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.bottom.equalTo(self.snp.centerY).offset(-5)
            $0.right.equalTo(centerBtn.snp.left).offset(-48)
        }
        
        //
        rightBtn
            .image("text_right_ic")
            .adhere(toSuperview: self)
        rightBtn.addTarget(self, action: #selector(rightBtnClick(sender: )), for: .touchUpInside)
        rightBtn.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.bottom.equalTo(self.snp.centerY).offset(-5)
            $0.left.equalTo(centerBtn.snp.right).offset(48)
        }
        
        
    }
    
    
    
    @objc func centerBtnClick(sender: UIButton) {
        alightmenClickBlock?(.center)
    }
    
    @objc func leftBtnClick(sender: UIButton) {
        alightmenClickBlock?(.left)
    }
    
    @objc func rightBtnClick(sender: UIButton) {
        alightmenClickBlock?(.right)
    }

}

extension HWymTextBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HWymTextColorCell.self, for: indexPath)
        let item = colorList[indexPath.item]
        cell.bgView.backgroundColor(item)
        if currentColorItem == item {
            cell.selectBgView.isHidden = false
        } else {
            cell.selectBgView.isHidden = true
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension HWymTextBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
}

extension HWymTextBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colorList[indexPath.item]
        
        currentColorItem = color
        collectionView.reloadData()
        colorClickBlock?(color)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}



class HWymTextColorCell: UICollectionViewCell {
    let bgView = UIView()
    let selectBgView = UIView()
     
    
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
            $0.width.height.equalTo(40)
        }
        bgView.layer.cornerRadius = 40/2
        //
        selectBgView
            .backgroundColor(UIColor.clear)
            .adhere(toSuperview: contentView)
        selectBgView.layer.cornerRadius = 40/2
        selectBgView.layer.borderColor = UIColor(hexString: "#EB6601")?.cgColor
        selectBgView.layer.borderWidth = 2
        selectBgView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(40)
        }
         
        
    }
}


