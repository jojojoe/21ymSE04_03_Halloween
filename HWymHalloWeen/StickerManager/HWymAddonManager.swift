//
//  HWymAddonManager.swift
//  HWymHalloWeen
//
//  Created by JOJO on 2021/10/19.
//


import Foundation
import UIKit
import Alertift

class HWymAddonManager: NSObject {
    
    static var `default` = HWymAddonManager()
    
    // sticker
    var addonStickersList: [HWymStickerTouchView] = []
    var currentStickerAddon: HWymStickerTouchView? = nil
    let stickerWidth = 100
    
    /*
    // bg photo
    var currentBgImageView: TMBgImageTouchView? = nil
    */
    
    /*
    // shape
    var addonShapesList: [IHymStickerTouchView] = []
    var currentShapeAddon: IHymStickerTouchView? = nil
    let shapeWidth =  200
    */
    // text
    var addonTextsList: [HWymTextTouchView] = []
    var currentTextAddon: HWymTextTouchView? = nil
    let textFontSize =  30
    let textDefaultString: String = "DOUBLE TAP TO TEXT"
    
    var isAllwaysAddNewTextView: Bool = false
    
    
    var doubleTapTextAddonActionBlock:((_ contentString: String, _ textFont: UIFont)->Void)?
    var shapeAddonReplaceBarStatusBlock:((_ shapeAddon: HWymStickerTouchView)->Void)?
    var textAddonReplaceBarStatusBlock:((_ textAddon: HWymTextTouchView)->Void)?
    var removeStickerAddonActionBlock:(()->Void)?
    
    
    func clearAddonManagerDefaultStatus() {
        addonStickersList = []
        currentStickerAddon = nil
        
//        addonShapesList = []
//        currentShapeAddon = nil
        
        addonTextsList = []
        currentTextAddon = nil
        
    }
    
    func cancelCurrentAddonHilightStatus() {
        if let currentSticker = currentStickerAddon {
            currentSticker.setHilight(false)
        }
        
//        if let curerntShape = currentShapeAddon {
//            curerntShape.setHilight(false)
//        }
        
        if let currentText = currentTextAddon {
            currentText.setHilight(false)
        }
        
    }
    
    
}

// sticker
extension HWymAddonManager {
    
    func addNewStickerAddonWithStickerImage(stickerImage: UIImage, stickerItem: HWStickerItem, atView stickerCanvasView:UIView) {
        
        cancelCurrentAddonHilightStatus()
        
        let stickerView: HWymStickerTouchView = HWymStickerTouchView.init(withImage:stickerImage , viewSize: CGSize.init(width: stickerWidth, height: stickerWidth))
        stickerView.center = CGPoint.init(x: stickerCanvasView.width() / 2, y: stickerCanvasView.height() / 2)
        addonStickersList.append(stickerView)
        currentStickerAddon = stickerView
        stickerCanvasView.addSubview(stickerView)
        stickerView.setHilight(true)
        stickerView.delegate = self
        stickerView.deleteActionBlock = { [weak self] contentTouchView in
            guard let `self` = self else { return }
            self.removeStickerTouchView(stickerTouchView: stickerView)
            
        }
        stickerView.flipActionBlock = { [weak self] contentTouchView in
            guard let `self` = self else { return }
            stickerView.contentImageview.image = stickerView.contentImageview.image?.withHorizontallyFlippedOrientation()
            
        }
        
        stickerView.stikerItem = stickerItem
        
    }
    
    
    func removeStickerTouchView(stickerTouchView: HWymStickerTouchView) {
        stickerTouchView.removeFromSuperview()
        
        addonStickersList.removeAll(stickerTouchView)
        currentStickerAddon = nil
        
        removeStickerAddonActionBlock?()
    }
    
    
}

/*
// bg photo
extension HWymAddonManager {
    func addBgPhotoAddonTouchImage(bgImage: UIImage, atView canvasView: UIView) {
        if let bgImageAddonView = currentBgImageView {
            // remove current bg photo addon
            
            removeBgPhotoTouchView(bgPhotoView: bgImageAddonView)
            
        }
        let whRatio: CGFloat = bgImage.size.width / bgImage.size.height
        var imageWidth: CGFloat = canvasView.width
        var imageHeight: CGFloat = canvasView.height
       
        let canvasWH = imageWidth / imageHeight
        
        
       if whRatio >= canvasWH {
        
           imageHeight = imageWidth / whRatio;
       } else {
            imageWidth = imageHeight * whRatio;
       }
       
       let contentImageViewSize: CGSize = CGSize.init(width: imageWidth, height: imageHeight)
        
        let bgPhotoView: TMBgImageTouchView = TMBgImageTouchView.init(withImage: bgImage, viewSize: contentImageViewSize)
        
        bgPhotoView.center = CGPoint.init(x: canvasView.width() / 2, y: canvasView.height() / 2)
        
        currentBgImageView = bgPhotoView
        
        canvasView.addSubview(bgPhotoView)
        canvasView.sendSubviewToBack(bgPhotoView)
        
    }
    
    func removeBgPhotoTouchView(bgPhotoView: TMBgImageTouchView) {
        bgPhotoView.removeFromSuperview()
        currentBgImageView = nil
    }
   
}
*/
/*
// shape
extension HWymAddonManager {
    
    func selectedOrAddNewCurrentShapeAddon(canvasView: UIView) -> Bool {
        guard let shapeAddon = currentShapeAddon else {
            
            if let lastShapeAddon = addonShapesList.last {
                currentShapeAddon = lastShapeAddon
                lastShapeAddon.setHilight(true)
                return true
            }
            
            guard let shapeItem = HookMacaqueToolManager.shapeItemsList.first else { return false }
            guard let shapeImage = UIImage.init(named: shapeItem.bigImageName()) else { return false }
            
            addNewShapeAddonWithShapeImage(shapeImage: shapeImage, itemIndexPath: IndexPath.init(item: 0, section: 0) , atView: canvasView)
            return true
        }
        
        shapeAddon.setHilight(true)
        return false
    }
    
    func addNewShapeAddonWithShapeImage(shapeImage: UIImage, itemIndexPath: IndexPath, atView stickerCanvasView:UIView) {
        
        
        cancelCurrentAddonHilightStatus()
        
        let stickerView: IHymStickerTouchView = IHymStickerTouchView.init(withImage:shapeImage , viewSize: CGSize.init(width: stickerWidth, height: stickerWidth) , isTemplete: true)
        stickerView.center = CGPoint.init(x: stickerCanvasView.width() / 2, y: stickerCanvasView.height() / 2)
        addonShapesList.append(stickerView)
        currentShapeAddon = stickerView
        stickerCanvasView.addSubview(stickerView)
        
        stickerView.setHilight(true)
        stickerView.delegate = self
        
        stickerView.itemIndexPath = itemIndexPath
        stickerView.colorIndexPath = IndexPath.init(item: 0, section: 0)
        stickerView.shapeAlpha = 1
        
        stickerView.deleteActionBlock = { [weak self] contentTouchView in
            guard let `self` = self else { return }
            self.removeShapeTouchView(stickerTouchView: stickerView)
            
        }
        
        shapeAddonReplaceBarStatusBlock?(stickerView)
        
    }
    
    func replaceSetupCurrentShapeAlpha(alpha: Float, canvasView: UIView) {
        cancelCurrentAddonHilightStatus()
        let isAddonNew = selectedOrAddNewCurrentShapeAddon(canvasView: canvasView)
        guard let shapeAddon = currentShapeAddon else { return }
        
        shapeAddon.setHilight(true)
        shapeAddon.contentImageview.alpha = CGFloat(alpha)
        shapeAddon.shapeAlpha = alpha
        if isAddonNew {
            shapeAddonReplaceBarStatusBlock?(shapeAddon)
        }
         
    }
    
    
    func replaceSetupCurrentShapeColor(shapeColorName: String, colorIndexPath:IndexPath , canvasView: UIView) {
        cancelCurrentAddonHilightStatus()
        let isAddonNew = selectedOrAddNewCurrentShapeAddon(canvasView: canvasView)
        guard let shapeAddon = currentShapeAddon else { return }
        shapeAddon.setHilight(true)
        shapeAddon.templeteColorString = shapeColorName
        shapeAddon.colorIndexPath = colorIndexPath
        if isAddonNew {
            shapeAddonReplaceBarStatusBlock?(shapeAddon)
        }
         
    }
    
    func removeShapeTouchView(stickerTouchView: IHymStickerTouchView) {
        stickerTouchView.removeFromSuperview()
        addonShapesList.removeAll(stickerTouchView)
        currentShapeAddon = nil
    }
    
    
}
*/

// text
extension HWymAddonManager {
    
    func selectedOrAddNewCurrentTextAddon(canvasView: UIView, isAddNew: Bool) -> Bool {
        if isAddNew == true {
            addNewTextAddonWithContentString(contentString: textDefaultString, atView: canvasView)
            if let textAddon = currentTextAddon {
                let attri_M = NSMutableAttributedString.init(attributedString: textAddon.contentAttributeString)
                attri_M.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FFFFFF") ?? UIColor.black], range: NSRange.init(location: 0, length: attri_M.length))
                textAddon.currentTextColorName = "#FFFFFF"
                textAddon.updateContentLabelWithAttributeString(attributeString: attri_M)
                textAddon.replaceCanvasContentAlpha(alpha: 0.7)
                textAddon.replaceSetupBgViewColor(bgColorName: "#FFFFFF")
                textAddon.textBgCornerRadius = 0
                textAddon.currentStrokeColorName = "clear"
            }
            
            return true
        } else {
            guard let textAddon = currentTextAddon else {
                
                if let lastTextAddon = addonTextsList.last, isAllwaysAddNewTextView == false {
                    currentTextAddon = lastTextAddon
                    lastTextAddon.setHilight(true)
                    return false
                } else {
                    addNewTextAddonWithContentString(contentString: textDefaultString, atView: canvasView)
                    if let textAddon = currentTextAddon {
                        let attri_M = NSMutableAttributedString.init(attributedString: textAddon.contentAttributeString)
                        attri_M.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(hexString:  "#FFFFFF") ?? UIColor.black], range: NSRange.init(location: 0, length: attri_M.length))
                        textAddon.currentTextColorName = "#FFFFFF"
                        textAddon.updateContentLabelWithAttributeString(attributeString: attri_M)
                        textAddon.replaceCanvasContentAlpha(alpha: 0.7)
                        textAddon.replaceSetupBgViewColor(bgColorName: "#FFFFFF")
                        textAddon.textBgCornerRadius = 0
                        textAddon.currentStrokeColorName = "clear"
                    }
                    return true
                }
            }
            
            textAddon.setHilight(true)
            return false
        }
        
    }
    
    func addNewTextAddonWithContentString(contentString: String, atView canvasView:UIView) {
        
        cancelCurrentAddonHilightStatus()
        
        var defaultFont = UIFont.systemFont(ofSize: CGFloat(textFontSize))
        let defaultColor: UIColor = UIColor.black
        
        defaultFont = UIFont(name: "Arial-BoldMT", size: CGFloat(textFontSize)) ?? UIFont.systemFont(ofSize: CGFloat(textFontSize))
        
//        if let fontItem = DataManager.default.textFontNames.first {
//            defaultFont = UIFont(name: fontItem, size: CGFloat(textFontSize)) ?? UIFont.systemFont(ofSize: CGFloat(textFontSize)) //fontItem.thinMetadataUniqueFx(fontSize: CGFloat(textFontSize))
//        }
        
        let style = NSMutableParagraphStyle.init()
        style.alignment = .center
        let attri = NSAttributedString.init(string: contentString, attributes: [NSAttributedString.Key.font : defaultFont, NSAttributedString.Key.foregroundColor : defaultColor, NSAttributedString.Key.paragraphStyle : style])
        
        let textView: HWymTextTouchView = HWymTextTouchView.init(withAttributeString: attri, canvasBounds: canvasView.bounds)
        textView.textFont = defaultFont
        textView.textBgCornerRadius = 0
        textView.center = CGPoint.init(x: canvasView.width() / 2, y: canvasView.height() / 2)
        addonTextsList.append(textView)
        currentTextAddon = textView
        canvasView.addSubview(textView)
        
        textView.setHilight(true)
        textView.delegate = self
        textView.deleteActionBlock = { [weak self] contentTouchView in
            guard let `self` = self else { return }
            self.removeTextTouchView(textTouchView: contentTouchView as! HWymTextTouchView)
            
        }
        
        textView.contentString = contentString
        
        textAddonReplaceBarStatusBlock?(textView)
        
    }
    
    func removeTextTouchView(textTouchView: HWymTextTouchView) {
        textTouchView.removeFromSuperview()
        addonTextsList.removeAll(textTouchView)
        currentTextAddon = nil
    }
    
    func replaceSetupTextAddonFontItem(fontItem: String, fontIndexPath: IndexPath, canvasView: UIView) {
        
        let isAddonNew = selectedOrAddNewCurrentTextAddon(canvasView: canvasView, isAddNew: false)
        
        guard let textAddon = currentTextAddon else { return }
        
        let attri_M = NSMutableAttributedString.init(attributedString: textAddon.contentAttributeString)
        
        let textFont: UIFont = UIFont(name: fontItem, size: CGFloat(textFontSize)) ?? UIFont.systemFont(ofSize: CGFloat(textFontSize)) //fontItem.thinMetadataUniqueFx(fontSize: CGFloat(textFontSize))
            
        attri_M.addAttributes([NSAttributedString.Key.font : textFont], range: NSRange.init(location: 0, length: attri_M.length))
        
        textAddon.updateContentLabelWithAttributeString(attributeString: attri_M)
        textAddon.fontIndexPath = fontIndexPath
        textAddon.textFont = textFont
        
        
        if isAddonNew {
            textAddonReplaceBarStatusBlock?(textAddon)
        }
        
    }
    
    func replaceSetupTextAddonText(aligment: NSTextAlignment, canvasView: UIView) {
        let isAddonNew = selectedOrAddNewCurrentTextAddon(canvasView: canvasView, isAddNew: false)
        guard let textAddon = currentTextAddon else { return }
        
        let attri_M = NSMutableAttributedString.init(attributedString: textAddon.contentAttributeString)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = aligment
        
        attri_M.addAttributes([NSAttributedString.Key.paragraphStyle : paragraph], range: NSRange.init(location: 0, length: attri_M.length))
        textAddon.updateContentLabelWithAttributeString(attributeString: attri_M)
        if isAddonNew {
            textAddonReplaceBarStatusBlock?(textAddon)
        }
    }
    
    func replaceSetupTextAddonTextColor(color: UIColor, canvasView: UIView) {

        let isAddonNew = selectedOrAddNewCurrentTextAddon(canvasView: canvasView, isAddNew: false)
        guard let textAddon = currentTextAddon else { return }
        
        let attri_M = NSMutableAttributedString.init(attributedString: textAddon.contentAttributeString)
        attri_M.addAttributes([NSAttributedString.Key.foregroundColor : color], range: NSRange.init(location: 0, length: attri_M.length))
        
        textAddon.updateContentLabelWithAttributeString(attributeString: attri_M)
        textAddon.textColorIndexPath = IndexPath(item: 0, section: 0)
        textAddon.currentTextColor = color
        if isAddonNew {
            textAddonReplaceBarStatusBlock?(textAddon)
        }
        
    }
    
    func replaceSetupTextAddonTextColorName(colorName: String, colorIndexPath: IndexPath, canvasView: UIView) {

        let isAddonNew = selectedOrAddNewCurrentTextAddon(canvasView: canvasView, isAddNew: false)
        guard let textAddon = currentTextAddon else { return }
        
        let attri_M = NSMutableAttributedString.init(attributedString: textAddon.contentAttributeString)
        attri_M.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init(hex: colorName) ?? UIColor.black], range: NSRange.init(location: 0, length: attri_M.length))
        
        textAddon.updateContentLabelWithAttributeString(attributeString: attri_M)
        textAddon.textColorIndexPath = colorIndexPath
        textAddon.currentTextColorName = colorName
        if isAddonNew {
            textAddonReplaceBarStatusBlock?(textAddon)
        }
        
    }
    
    func replaceSetupTextAddonTextStrokeColorName(strokeColorName: String, canvasView: UIView) {
        
        let isAddonNew = selectedOrAddNewCurrentTextAddon(canvasView: canvasView, isAddNew: false)
        guard let textAddon = currentTextAddon else { return }
        
        let attri_M = NSMutableAttributedString.init(attributedString: textAddon.contentAttributeString)
        attri_M.addAttributes([NSAttributedString.Key.strokeWidth : -3 , NSAttributedString.Key.strokeColor : UIColor.init(hex: strokeColorName) ?? UIColor.clear], range: NSRange.init(location: 0, length: attri_M.length))
        textAddon.updateContentLabelWithAttributeString(attributeString: attri_M)
        textAddon.currentStrokeColorName = strokeColorName
        
        if isAddonNew {
            textAddonReplaceBarStatusBlock?(textAddon)
        }
        
    }
    
    func replaceSetupTextAddonTextAlpha(alpha: CGFloat, canvasView: UIView) {
        let isAddonNew = selectedOrAddNewCurrentTextAddon(canvasView: canvasView, isAddNew: false)
        guard let textAddon = currentTextAddon else { return }
        textAddon.replaceCanvasContentAlpha(alpha: alpha)
        
        if isAddonNew {
            textAddonReplaceBarStatusBlock?(textAddon)
        }
    }
    
    func replaceSetupTextBgColor(bgColorName: String, indexPath: IndexPath, canvasView: UIView) {
        let isAddonNew = selectedOrAddNewCurrentTextAddon(canvasView: canvasView, isAddNew: false)
        guard let textAddon = currentTextAddon else { return }
        
        textAddon.replaceSetupBgViewColor(bgColorName: bgColorName)
        
        textAddon.bgColorIndexPath = indexPath
        if isAddonNew {
            textAddonReplaceBarStatusBlock?(textAddon)
        }
    }
    
    func replaceSetupTextBgBorderColor(bgBorderColorName: String, canvasView: UIView) {
        let isAddonNew = selectedOrAddNewCurrentTextAddon(canvasView: canvasView, isAddNew: false)
        guard let textAddon = currentTextAddon else { return }
        
        textAddon.replaceSetupBgViewBorderColor(bgBorderColorName: bgBorderColorName)
        
        if isAddonNew {
            textAddonReplaceBarStatusBlock?(textAddon)
        }
        
    }
    
    func replaceSetupTextBgCornerRadius(cornerRadius: CGFloat, canvasView: UIView) {
        let isAddonNew = selectedOrAddNewCurrentTextAddon(canvasView: canvasView, isAddNew: false)
        guard let textAddon = currentTextAddon else { return }
        
        textAddon.replaceSetupBgViewCornerRadius(cornerRadius: cornerRadius)
        textAddon.textBgCornerRadius = cornerRadius
        
        if isAddonNew {
            textAddonReplaceBarStatusBlock?(textAddon)
        }
    }
    
    //TODO: ??????????????????
    func replaceSetupTextContentString(contentString: String, canvasView: UIView, isAddNewTextAddon: Bool) {
        
        let isAddonNew = selectedOrAddNewCurrentTextAddon(canvasView: canvasView, isAddNew: isAddNewTextAddon)
        
        guard let textAddon = currentTextAddon else { return }
        textAddon.contentString = contentString
        
        let attri_M = NSMutableAttributedString.init(attributedString: textAddon.contentAttributeString)
        attri_M.replaceCharacters(in: NSRange.init(location: 0, length: attri_M.length), with: contentString)
        
        textAddon.updateContentLabelWithAttributeString(attributeString: attri_M)
        
        if isAddonNew {
            textAddonReplaceBarStatusBlock?(textAddon)
        }
    }
}




extension HWymAddonManager: TouchStuffViewDelegate {
    
    func viewDoubleClick(_ sender: TouchStuffView!) {
//        cancelCurrentAddonHilightStatus()
        sender.setHilight(true)
        
        let className = type(of: sender).description()
        if className.contains("HWymTextTouchView") {
            let textAddon: HWymTextTouchView = sender as! HWymTextTouchView
            currentTextAddon = textAddon
               
            doubleTapTextAddonActionBlock?(textAddon.contentString, textAddon.textFont)
        }
        
    }
    
    func viewSingleClick(_ sender: TouchStuffView!) {
//        cancelCurrentAddonHilightStatus()
        var allAddonList = addonStickersList + addonTextsList
        
        for addone in allAddonList {
            if addone == sender {
                if sender.isHilightStatus == true {
                    sender.setHilight(false)
                } else {
                    sender.setHilight(true)
                }
            } else {
                addone.setHilight(false)
            }
        }
        
        
        let className = type(of: sender).description()
        
        if className.contains("IHymStickerTouchView") {
            let stickerAddon: HWymStickerTouchView = sender as! HWymStickerTouchView
            if addonStickersList.contains(stickerAddon) {
                currentStickerAddon = stickerAddon
            }
            stickerAddon.superview?.bringSubviewToFront(stickerAddon)
        } else if className.contains("HWymTextTouchView") {
            let textAddon: HWymTextTouchView = sender as! HWymTextTouchView
            currentTextAddon = textAddon
            textAddonReplaceBarStatusBlock?(textAddon)
            textAddon.superview?.bringSubviewToFront(textAddon)
        }
        
    }
    
    func viewTouchUp(_ sender: TouchStuffView!) {
        
    }
    
}

