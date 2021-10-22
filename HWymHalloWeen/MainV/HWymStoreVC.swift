//
//  HWymStoreVC.swift
//  HWymHalloWeen
//
//  Created by JOJO on 2021/10/18.
//

import UIKit
import NoticeObserveKit
import ZKProgressHUD

class HWymStoreVC: UIViewController {
    private var pool = Notice.ObserverPool()
    var collection: UICollectionView!
    let topCoinLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor(UIColor(hexString: "#1C1C1C")!)
        view.clipsToBounds()
        setupView()
        addNotificationObserver()
        
    }
    
    func addNotificationObserver() {
        
        NotificationCenter.default.nok.observe(name: .pi_noti_coinChange) {[weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.topCoinLabel.text = ("Your coins: " + "\(HWymCoinManager.default.coinCount)")
            }
        }
        .invalidated(by: pool)
        
    }
    
    
    func setupView() {
        let backBtn = UIButton(type: .custom)
        view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "edit_pic_back"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        
        //
        let title1 = UILabel()
        title1
            .color(UIColor(hexString: "#EB6601")!)
            .text("Store")
            .fontName(16, "AvenirNext-Medium")
            .adhere(toSuperview: view)
        title1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backBtn.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        let iconImgV = UIImageView()
        iconImgV
            .image("popup_pro_ic")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: view)
        iconImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(title1.snp.bottom).offset(20)
            $0.width.height.equalTo(58)
        }
        
        //
        
        topCoinLabel
            .color(UIColor(hexString: "#EB6601")!)
            .text("Your coins: " + "\(HWymCoinManager.default.coinCount)")
            .fontName(16, "AvenirNext-Bold")
            .adhere(toSuperview: view)
        topCoinLabel.snp.makeConstraints {
            $0.top.equalTo(iconImgV.snp.bottom).offset(12)
            $0.centerX.equalTo(iconImgV.snp.centerX)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
         
        // collection
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.layer.masksToBounds = true
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topCoinLabel.snp.bottom).offset(18)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        collection.register(cellWithClass: HWymStoreCell.self)
    }
    
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController()
        }
    }

}


extension HWymStoreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HWymStoreCell.self, for: indexPath)
        let item = HWymCoinManager.default.coinIpaItemList[indexPath.item]
        cell.coinCountLabel.text = "x \(item.coin)"
        cell.priceLabel.text = item.price
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HWymCoinManager.default.coinIpaItemList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension HWymStoreVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let left: CGFloat = 22
        let offset: CGFloat = 12
        
        let cellwidth: CGFloat = (UIScreen.main.bounds.width - 22 * 2 - 12 - 1) / 2
        let cellHeight: CGFloat = (148/160) * cellwidth
        
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let left: CGFloat = 22
        return UIEdgeInsets(top: 20, left: left, bottom: 20, right: left)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let padding: CGFloat = 12
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let padding: CGFloat = 12
        return padding
    }
    
}

extension HWymStoreVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = HWymCoinManager.default.coinIpaItemList[safe: indexPath.item] {
            selectCoinItem(item: item)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func selectCoinItem(item: StoreItem) {
        HWymCoinManager.default.purchaseIapId(item: item) { (success, errorString) in
            
            if success {
                ZKProgressHUD.showSuccess("Purchase successful.")
            } else {
                ZKProgressHUD.showError("Purchase failed.")
            }
        }
    }
    
}

class HWymStoreCell: UICollectionViewCell {
    
    var bgView: UIView = UIView()
    
    var bgImageV: UIImageView = UIImageView()
    var coverImageV: UIImageView = UIImageView()
    var coinCountLabel: UILabel = UILabel()
    var priceLabel: UILabel = UILabel()
    var priceBgImgV: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        backgroundColor = UIColor.clear //UIColor(hexString: "#149CF5")?.withAlphaComponent(0.2)
        bgView.backgroundColor = UIColor(hexString: "#EB6601")
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        bgView.layer.cornerRadius = 16
        bgView.layer.masksToBounds = true
 
        //
        coinCountLabel.adjustsFontSizeToFitWidth = true
        coinCountLabel
            .color(UIColor(hexString: "#000000")!)
            .numberOfLines(1)
            .fontName(16, "AvenirNext-Bold")
            .textAlignment(.center)
            .adhere(toSuperview: bgView)

        coinCountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(4)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        bgImageV.backgroundColor = .clear
        bgImageV.contentMode = .scaleAspectFit
        bgImageV.image = UIImage(named: "popup_pro_ic")
        contentView.addSubview(bgImageV)
        bgImageV.snp.makeConstraints {
            $0.bottom.equalTo(coinCountLabel.snp.top).offset(-12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(44)
            $0.height.equalTo(44)
            
        }
         
        
        
        //
        bgView.addSubview(priceBgImgV)
        priceBgImgV
            .contentMode(.scaleToFill)
            .image("popup_btn_bg_ic")
//        priceBgImgV.layer.cornerRadius = 8
//        priceBgImgV.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
//        priceBgImgV.layer.shadowOffset = CGSize(width: 0, height: 2)
//        priceBgImgV.layer.shadowRadius = 2
//        priceBgImgV.layer.shadowOpacity = 0.8
//
        
        priceBgImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(10)
            $0.top.equalTo(coinCountLabel.snp.bottom).offset(18)
            $0.height.equalTo(30)
        }
        
        //
        priceLabel.textColor = UIColor(hexString: "#FF7D1A")
        priceLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        priceLabel.textAlignment = .center
        bgView.addSubview(priceLabel)
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.snp.makeConstraints {
            $0.center.equalTo(priceBgImgV)
            $0.height.greaterThanOrEqualTo(22)
            $0.left.equalTo(priceBgImgV.snp.left).offset(4)
        }
        
    }
     
}

