//
//  HWymEditVC.swift
//  HWymHalloWeen
//
//  Created by JOJO on 2021/10/18.
//

import UIKit
import Photos

class HWymEditVC: UIViewController {
    let contentImgV = UIImageView()
    var originalImg: UIImage
    let backBtn = UIButton(type: .custom)
    let editToolBar = UIButton()
    let canvasBgView = UIView()
    let filterBtn = UIButton(type: .custom)
    let textinputView = HWymTextINputV()
    var toolViews: [UIView] = []
    let coinAlertView = HWymUnlockAlerV()
    
    let headwearBtn = HWymEditBottomBtn(frame: .zero, iconName: "headwear_ic", nameStr: "Headwear")
    let maskBtn = HWymEditBottomBtn(frame: .zero, iconName: "mask_ic", nameStr: "Mask")
    let textBtn = HWymEditBottomBtn(frame: .zero, iconName: "text_ic", nameStr: "Text")
    let maskStickerBar = HWymStickerBar(frame: .zero, type: .mask)
    let headwearStickerBar = HWymStickerBar(frame: .zero, type: .headwear)
    let textBar = HWymTextBar(frame: .zero)
    
    var isAddNewTextAddon: Bool = false
    var shouldCostCoin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupToolBar()
        setupUnlockAlertView()
        setupActionBlock()
        showToolView(toolView: maskStickerBar, btn: maskBtn)
        let aTapGR = UITapGestureRecognizer.init(target: self, action: #selector(editingHandlers))
        canvasBgView.addGestureRecognizer(aTapGR)
    }
    
    init(originalImg: UIImage) {
        self.originalImg = originalImg
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height: CGFloat = editToolBar.frame.minY - backBtn.frame.maxY - 20
        let width: CGFloat = height * 3/4
        
        canvasBgView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width)
            $0.bottom.equalTo(editToolBar.snp.top).offset(-10)
            $0.top.equalTo(backBtn.snp.bottom).offset(10)
        }
    }
    
    func setupView() {
        view
            .backgroundColor(UIColor(hexString: "#1C1C1C")!)
        view.clipsToBounds()
        //
        let bgImgV = UIImageView()
        bgImgV
            .image("edit_pic_bg")
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: view)
        bgImgV
            .snp.makeConstraints {
                $0.left.right.top.bottom.equalToSuperview()
            }
        
        //
        
        backBtn
            .image(UIImage(named: "edit_pic_back"))
            .adhere(toSuperview: view)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        //
        let topLabel = UILabel()
        topLabel
            .text("Edit")
            .color(UIColor(hexString: "#EB6601")!)
            .fontName(16, "AvenirNext-Medium")
            .adhere(toSuperview: view)
        topLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backBtn.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        let saveBtn = UIButton(type: .custom)
        saveBtn
            .image(UIImage(named: "edilt_save_pic"))
            .adhere(toSuperview: view)
        saveBtn.addTarget(self, action: #selector(saveBtnClick(sender: )), for: .touchUpInside)
        saveBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.right.equalTo(-10)
            $0.width.height.equalTo(44)
        }
        
        //
        let bottomBar = UIView()
        bottomBar
            .backgroundColor(UIColor.clear)
            .adhere(toSuperview: view)
        bottomBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-93)
        }
        let bottomBgImgV = UIImageView()
        bottomBgImgV
            .image("edit_nav_bg_ic")
            .contentMode(.scaleToFill)
            .adhere(toSuperview: bottomBar)
        bottomBgImgV.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
            
        }
        //
        
        
        headwearBtn.adhere(toSuperview: bottomBar)
        maskBtn.adhere(toSuperview: bottomBar)
        textBtn.adhere(toSuperview: bottomBar)
        
        headwearBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(90)
        }
        
        maskBtn.snp.makeConstraints {
            $0.right.equalTo(headwearBtn.snp.left).offset(-50)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(90)
        }
        
        textBtn.snp.makeConstraints {
            $0.left.equalTo(headwearBtn.snp.right).offset(50)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(90)
        }
        
        headwearBtn.addTarget(self, action: #selector(headwearBtnClick(sender: )), for: .touchUpInside)
        maskBtn.addTarget(self, action: #selector(maskBtnClick(sender:)), for: .touchUpInside)
        textBtn.addTarget(self, action: #selector(textBtnClick(sender:)), for: .touchUpInside)
        
        //
        
        editToolBar
            .backgroundColor(.clear)
            .adhere(toSuperview: view)
        editToolBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(bottomBar.snp.top)
            $0.height.equalTo(125)
        }
        
        //
        
        canvasBgView
            .clipsToBounds()
            .backgroundColor(UIColor.clear)
            .backgroundColor(UIColor.white)
            .adhere(toSuperview: view)
        canvasBgView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.bottom.equalTo(editToolBar.snp.top)
            $0.top.equalTo(backBtn.snp.bottom).offset(0)
        }
        //
        
        contentImgV
            .image(originalImg)
            .contentMode(.scaleAspectFill)
            .clipsToBounds()
            .adhere(toSuperview: canvasBgView)
        contentImgV.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        //
        filterBtn
            .image("pic_filter_ic")
            .adhere(toSuperview: view)
        filterBtn.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.bottom.equalTo(canvasBgView.snp.bottom).offset(5)
            $0.right.equalTo(canvasBgView.snp.right).offset(5)
        }
        filterBtn.addTarget(self, action: #selector(filterBtnClick(sender: )), for: .touchUpInside)
        
    }

    func setupToolBar() {
//        editToolBar
        
        maskStickerBar
            .adhere(toSuperview: editToolBar)
        maskStickerBar.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        maskStickerBar.stickerClickBlock = {
            [weak self] item in
            guard let `self` = self else {return}
            guard let stickerImage = UIImage(named: item.bigName ?? "") else {return}
            HWymAddonManager.default.addNewStickerAddonWithStickerImage(stickerImage: stickerImage, stickerItem: item, atView: self.canvasBgView)
            
        }
        //
        
        headwearStickerBar
            .adhere(toSuperview: editToolBar)
        headwearStickerBar.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        headwearStickerBar.stickerClickBlock = {
            [weak self] item in
            guard let `self` = self else {return}
            guard let stickerImage = UIImage(named: item.bigName ?? "") else {return}
            HWymAddonManager.default.addNewStickerAddonWithStickerImage(stickerImage: stickerImage, stickerItem: item, atView: self.canvasBgView)
            
        
        }
        //
        
        textBar
            .adhere(toSuperview: editToolBar)
        textBar.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        textBar.colorClickBlock = {
            [weak self] item in
            guard let `self` = self else {return}
         
            HWymAddonManager.default.replaceSetupTextAddonTextColor(color: item, canvasView: self.canvasBgView)
            self.addNewfirstTextView()
        }
        textBar.alightmenClickBlock = {
            [weak self] alightment in
            guard let `self` = self else {return}
            HWymAddonManager.default.replaceSetupTextAddonText(aligment: alightment, canvasView: self.canvasBgView)
            self.addNewfirstTextView()
        }
         
        toolViews = []
        toolViews.append(maskStickerBar)
        toolViews.append(headwearStickerBar)
        toolViews.append(textBar)
    }
     
    func setupUnlockAlertView() {
        
        coinAlertView.alpha = 0
        view.addSubview(coinAlertView)
        coinAlertView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        
    }
    
    func savePhotoAction() {
        if let img = canvasBgView.screenshot {
            saveToAlbumPhotoAction(images: [img])
        }
    }
    
    func showUnlockCoinAlertView() {
        // show coin alert
        UIView.animate(withDuration: 0.35) {
            self.coinAlertView.alpha = 1
        }
        
        coinAlertView.okBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            
            if HWymCoinManager.default.coinCount >= HWymCoinManager.default.coinCostCount {
                DispatchQueue.main.async {
                    self.savePhotoAction()
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: "Insufficient coins, please buy first.", buttonTitles: ["OK"], highlightedButtonIndex: 0) { i in
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let `self` = self else {return}
                            self.present(HWymStoreVC(), animated: true, completion: nil)
                            
                        }
                    }
                }
            }

            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            } completion: { finished in
                 
            }
        }
        
        
        coinAlertView.backBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            } completion: { _ in
                
            }
        }
    }
    
    @objc func backBtnClick(sender: UIButton) {
        HWymAddonManager.default.clearAddonManagerDefaultStatus()
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func saveBtnClick(sender: UIButton) {
        HWymAddonManager.default.cancelCurrentAddonHilightStatus()
        if checkTopProAlertStatus() {
            shouldCostCoin = true
            showUnlockCoinAlertView()
        } else {
            shouldCostCoin = false
            savePhotoAction()
        }
    }
    
    @objc func headwearBtnClick(sender: HWymEditBottomBtn) {
        HWymAddonManager.default.cancelCurrentAddonHilightStatus()
        showToolView(toolView: headwearStickerBar, btn: sender)
    }
    
    @objc func maskBtnClick(sender: HWymEditBottomBtn) {
        HWymAddonManager.default.cancelCurrentAddonHilightStatus()
        showToolView(toolView: maskStickerBar, btn: sender)
    }
    
    @objc func textBtnClick(sender: HWymEditBottomBtn) {
        HWymAddonManager.default.cancelCurrentAddonHilightStatus()
        showToolView(toolView: textBar, btn: sender)
        if let textView = HWymAddonManager.default.addonTextsList.first, textView.superview != nil {
            HWymAddonManager.default.currentTextAddon = textView
            textView.setHilight(true)
            textView.superview?.bringSubviewToFront(textView)
        } else {
            isAddNewTextAddon = true
            let defaulTextStr = ""
            let defaultFont = UIFont(name: "Creepster-Regular", size: 40) ?? UIFont.systemFont(ofSize: 40)
            self.showTextInputViewStatus(contentString: defaulTextStr, font: defaultFont)
        }
        
    }
    @objc func filterBtnClick(sender: UIButton) {
        HWymAddonManager.default.cancelCurrentAddonHilightStatus()
        let img = DataManager.default.randomFilter(originalImg: originalImg)
        contentImgV.image = img
    }
    
    @objc func editingHandlers() {
        HWymAddonManager.default.cancelCurrentAddonHilightStatus()
    }
}


extension HWymEditVC {
    func saveToAlbumPhotoAction(images: [UIImage]) {
        DispatchQueue.main.async(execute: {
            PHPhotoLibrary.shared().performChanges({
                [weak self] in
                guard let `self` = self else {return}
                for img in images {
                    PHAssetChangeRequest.creationRequestForAsset(from: img)
                }
            }) { (finish, error) in
                if finish {
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        self.showSaveSuccessAlert()
                        if self.shouldCostCoin {
                            HWymCoinManager.default.costCoin(coin: HWymCoinManager.default.coinCostCount)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        if error != nil {
                            let auth = PHPhotoLibrary.authorizationStatus()
                            if auth != .authorized {
                                self.showDenideAlert()
                            }
                        }
                    }
                }
            }
        })
    }
    
    func showSaveSuccessAlert() {
        HUD.success("Photo saved successful.")
    }
    
    func showDenideAlert() {
        DispatchQueue.main.async {
            [weak self] in
            guard let `self` = self else {return}
            let alert = UIAlertController(title: "Oops", message: "You have declined access to photos, please active it in Settings>Privacy>Photos.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (goSettingAction) in
                DispatchQueue.main.async {
                    let url = URL(string: UIApplication.openSettingsURLString)!
                    UIApplication.shared.open(url, options: [:])
                }
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
    }
    
}
extension HWymEditVC {
    func checkTopProAlertStatus() -> Bool {
        var isStickerPro: Bool = false
        
        for stickerView in HWymAddonManager.default.addonStickersList {
            if stickerView.stikerItem?.isPro == true {
                isStickerPro = true
                break
            }
        }
        return isStickerPro
    }
    func setupActionBlock() {
         
        HWymAddonManager.default.doubleTapTextAddonActionBlock = { [weak self] contentString, font in
            guard let `self` = self else {return}
            self.isAddNewTextAddon = false
            self.showTextInputViewStatus(contentString: contentString, font: font)
            
        }
        
        HWymAddonManager.default.textAddonReplaceBarStatusBlock = { [weak self] textAddon in
            guard let `self` = self else {return}
            
        }
        
        
        HWymAddonManager.default.removeStickerAddonActionBlock = { [weak self] in
            guard let `self` = self else {return}
//            self.checkTopProAlertStatus()
            
        }
        
    }
}

extension HWymEditVC {
    func showToolView(toolView: UIView, btn: HWymEditBottomBtn) {
        
        for subView in toolViews {
            if toolView == subView {
                subView.isHidden = false
            } else {
                subView.isHidden = true
            }
        }
         
        
    }
    
    func showTextInputViewStatus(contentString: String, font: UIFont) {
        let textinputVC = HWymTextINputV()
        self.addChild(textinputVC)
        view.addSubview(textinputVC.view)
        textinputVC.view.alpha = 0
        textinputVC.startEdit()
        if contentString == "" {
//            textinputVC.contentTextView.placeholder = "Halloween"
        } else {
            textinputVC.contentText = contentString
//            textinputVC.contentTextView.text = contentString
        }
        UIView.animate(withDuration: 0.25) {
            [weak self] in
            guard let `self` = self else {return}
            textinputVC.view.alpha = 1
        }
        textinputVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        textinputVC.contentTextView.becomeFirstResponder()
        textinputVC.cancelClickActionBlock = {
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let `self` = self else {return}
                textinputVC.view.alpha = 0
            } completion: {[weak self] (finished) in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    [weak self] in
                    guard let `self` = self else {return}
                    textinputVC.removeViewAndControllerFromParentViewController()
                }
            }

            
            
            textinputVC.contentTextView.resignFirstResponder()
        }
        textinputVC.doneClickActionBlock = {
            [weak self] contentString, isAddNew in
            guard let `self` = self else {return}
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let `self` = self else {return}
                textinputVC.view.alpha = 0
            } completion: {[weak self] (finished) in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    [weak self] in
                    guard let `self` = self else {return}
                    textinputVC.removeViewAndControllerFromParentViewController()
                }
            }
            textinputVC.contentTextView.resignFirstResponder()
            HWymAddonManager.default.replaceSetupTextContentString(contentString: contentString, canvasView: self.canvasBgView, isAddNewTextAddon: self.isAddNewTextAddon)
            self.addNewfirstTextView()
        }
    }
    
    func addNewfirstTextView() {
        
        HWymAddonManager.default.replaceSetupTextAddonFontItem(fontItem: "Creepster-Regular", fontIndexPath: IndexPath(item: 0, section: 0), canvasView: self.canvasBgView)
        
        HWymAddonManager.default.replaceSetupTextBgColor(bgColorName: "#00000000", indexPath: IndexPath(item: 0, section: 0), canvasView: self.canvasBgView)
    }
}




class HWymEditBottomBtn: UIButton {
    let iconImgV = UIImageView()
    let nameLabel = UILabel()
    var iconName: String
    var nameStr: String
    init(frame: CGRect, iconName: String, nameStr: String) {
        self.iconName = iconName
        self.nameStr = nameStr
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        iconImgV
            .image(iconName)
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: self)
        iconImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(snp.centerY).offset(0)
            $0.width.equalTo(27)
            $0.height.equalTo(27)
        }
        //
        nameLabel
            .text(nameStr)
            .color(UIColor.black)
            .fontName(10, "AvenirNext-Medium")
            .adhere(toSuperview: self)
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(iconImgV.snp.bottom).offset(7)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
    }
    
}




