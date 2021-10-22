//
//  HWymUnlockAlerV.swift
//  HWymHalloWeen
//
//  Created by JOJO on 2021/10/19.
//

import UIKit
 
class HWymUnlockAlerV: UIView {

    
    var backBtnClickBlock: (()->Void)?
    var okBtnClickBlock: (()->Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func backBtnClick(sender: UIButton) {
        backBtnClickBlock?()
    }
    
    func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        //
        let bgBtn = UIButton(type: .custom)
        bgBtn
            .image(UIImage(named: ""))
            .adhere(toSuperview: self)
        bgBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        bgBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        let contentV = UIView()
            .backgroundColor(UIColor(hexString: "#EB6601")!)
            .adhere(toSuperview: self)
        contentV.layer.cornerRadius = 30
        contentV.layer.masksToBounds = true
        contentV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
            $0.width.equalTo(300)
            $0.height.equalTo(278)
        }
        //
        let iconImgV = UIImageView()
            .image("popup_pro_ic")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: contentV)
        iconImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentV.snp.top).offset(30)
            $0.width.height.equalTo(83)
        }
        
        //
        let backBtn = UIButton(type: .custom)
        backBtn
            .image(UIImage(named: "popup_close_ic"))
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        
        addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.right.equalTo(snp.right).offset(-10)
            $0.width.height.equalTo(44)
        }
        //
        
        let titLab = UILabel()
        

            .text("\(HWymCoinManager.default.coinCostCount) coins will be deducted for unlock paid items.")
            .textAlignment(.center)
            .numberOfLines(0)
            .fontName(16, "AvenirNext-Medium")
            .color(.black)
            .adhere(toSuperview: contentV)
        
        titLab.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(iconImgV.snp.bottom).offset(20)
            $0.left.equalTo(25)
            $0.height.greaterThanOrEqualTo(1)
        }
        //AvenirNext-DemiBold
        let okBtn = UIButton(type: .custom)
        okBtn.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)
        okBtn.setTitleColor(UIColor(hexString: "#FF7D1A"), for: .normal)
        okBtn
            .backgroundImage(UIImage(named: "popup_btn_bg_ic"))
            .title("OK")
        okBtn.addTarget(self, action: #selector(okBtnClick(sender:)), for: .touchUpInside)
        
        contentV.addSubview(okBtn)
        okBtn.snp.makeConstraints {
            $0.bottom.equalTo(contentV.snp.bottom).offset(-20)
            $0.centerX.equalToSuperview()
            $0.left.equalTo(10)
            $0.height.equalTo(60)
        }
        
    }
    @objc func okBtnClick(sender: UIButton) {
        okBtnClickBlock?()
    }
}
