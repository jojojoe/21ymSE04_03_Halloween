//
//  Manager.swift
//  HWymHalloWeen
//
//  Created by JOJO on 2021/10/19.
//

import Foundation
import SwifterSwift
import UIKit

struct HWStickerItem: Codable {
    var thumbName: String?
    var bigName: String?
    var isPro: Bool = false
}

class DataManager: NSObject {
    static let `default` = DataManager()
    var filterNameList: [String] = []
    var currentFitelrName: String?
    var currentFitelrIndex: Int = 0
    override init() {
        super.init()
        if let filterName = FilterDataTool.colorMatrixList() as? [String] {
            filterNameList = filterName
        }
        
    }
    
    var maskStickerList : [HWStickerItem] {
        return DataManager.default.loadJson([HWStickerItem].self, name: "maskSticker") ?? []
    }
    var headwearStickerList: [HWStickerItem] {
        return DataManager.default.loadJson([HWStickerItem].self, name: "headwearSticker") ?? []
    }
    
    func getColorData() -> [UIColor] {
        var colorArr: [UIColor] = []
        colorArr.append(UIColor.white)
        colorArr.append(UIColor.black)
        colorArr.append(MyColorFunc(187, 36, 108, 1.0)!)
//        colorArr.append(MyColorFunc(193, 37, 72, 1.0)!)
//        colorArr.append(MyColorFunc(217, 53, 89, 1.0)!)
        colorArr.append(MyColorFunc(196, 52, 96, 1.0)!)
        colorArr.append(MyColorFunc(194, 92, 105, 1.0)!)
        colorArr.append(MyColorFunc(234, 117, 141, 1.0)!)
//        colorArr.append(MyColorFunc(229, 128, 132, 1.0)!)
//        colorArr.append(MyColorFunc(208, 131, 108, 1.0)!)
        colorArr.append(MyColorFunc(230, 136, 143, 1.0)!)
        colorArr.append(MyColorFunc(207, 140, 144, 1.0)!)
        colorArr.append(MyColorFunc(242, 174, 186, 1.0)!)
        colorArr.append(MyColorFunc(240, 174, 163, 1.0)!)
//        colorArr.append(MyColorFunc(246, 210, 203, 1.0)!)
//        colorArr.append(MyColorFunc(231, 138, 164, 1.0)!)
        colorArr.append(MyColorFunc(217, 80, 104, 1.0)!)
        colorArr.append(MyColorFunc(212, 42, 36, 1.0)!)
        colorArr.append(MyColorFunc(195, 39, 37, 1.0)!)
        colorArr.append(MyColorFunc(139, 31, 53, 1.0)!)
        colorArr.append(MyColorFunc(86, 29, 47, 1.0)!)
        colorArr.append(MyColorFunc(165, 104, 119, 1.0)!)
        colorArr.append(MyColorFunc(221, 85, 53, 1.0)!)
        colorArr.append(MyColorFunc(226, 102, 78, 1.0)!)
        colorArr.append(MyColorFunc(224, 104, 38, 1.0)!)
        colorArr.append(MyColorFunc(227, 129, 46, 1.0)!)
        colorArr.append(MyColorFunc(237, 132, 83, 1.0)!)
//        colorArr.append(MyColorFunc(239, 175, 113, 1.0)!)
//        colorArr.append(MyColorFunc(209, 148, 109, 1.0)!)
        colorArr.append(MyColorFunc(216, 189, 177, 1.0)!)
        colorArr.append(MyColorFunc(205, 179, 145, 1.0)!)
        colorArr.append(MyColorFunc(188, 158, 130, 1.0)!)
        colorArr.append(MyColorFunc(150, 113, 84, 1.0)!)
        colorArr.append(MyColorFunc(86, 51, 35, 1.0)!)
        colorArr.append(MyColorFunc(91, 57, 35, 1.0)!)
        colorArr.append(MyColorFunc(86, 67, 42, 1.0)!)
        colorArr.append(MyColorFunc(241, 151, 41, 1.0)!)
        colorArr.append(MyColorFunc(244, 196, 45, 1.0)!)
        colorArr.append(MyColorFunc(249, 204, 122, 1.0)!)
        colorArr.append(MyColorFunc(249, 220, 166, 1.0)!)
        colorArr.append(MyColorFunc(215, 210, 193, 1.0)!)
//        colorArr.append(MyColorFunc(255, 250, 157, 1.0)!)
//        colorArr.append(MyColorFunc(254, 246, 105, 1.0)!)
//        colorArr.append(MyColorFunc(254, 242, 55, 1.0)!)
        colorArr.append(MyColorFunc(217, 196, 88, 1.0)!)
        colorArr.append(MyColorFunc(187, 178, 101, 1.0)!)
        colorArr.append(MyColorFunc(146, 111, 33, 1.0)!)
        colorArr.append(MyColorFunc(145, 116, 65, 1.0)!)
        colorArr.append(MyColorFunc(159, 203, 48, 1.0)!)
        colorArr.append(MyColorFunc(123, 172, 59, 1.0)!)
        colorArr.append(MyColorFunc(128, 193, 111, 1.0)!)
        colorArr.append(MyColorFunc(109, 141, 95, 1.0)!)
        colorArr.append(MyColorFunc(133, 177, 110, 1.0)!)
        colorArr.append(MyColorFunc(111, 115, 71, 1.0)!)
//        colorArr.append(MyColorFunc(82, 79, 37, 1.0)!)
//        colorArr.append(MyColorFunc(68, 141, 158, 1.0)!)
        colorArr.append(MyColorFunc(78, 173, 123, 1.0)!)
        colorArr.append(MyColorFunc(25, 161, 110, 1.0)!)
        colorArr.append(MyColorFunc(53, 155, 137, 1.0)!)
        colorArr.append(MyColorFunc(96, 168, 145, 1.0)!)
        colorArr.append(MyColorFunc(18, 126, 88, 1.0)!)
        colorArr.append(MyColorFunc(12, 105, 77, 1.0)!)
        colorArr.append(MyColorFunc(10, 88, 75, 1.0)!)
        colorArr.append(MyColorFunc(14, 114, 110, 1.0)!)
        colorArr.append(MyColorFunc(140, 201, 197, 1.0)!)
        colorArr.append(MyColorFunc(121, 195, 217, 1.0)!)
        colorArr.append(MyColorFunc(61, 182, 204, 1.0)!)
//        colorArr.append(MyColorFunc(47, 154, 219, 1.0)!)
//        colorArr.append(MyColorFunc(120, 174, 207, 1.0)!)
//        colorArr.append(MyColorFunc(143, 186, 198, 1.0)!)
        colorArr.append(MyColorFunc(111, 148, 171, 1.0)!)
        colorArr.append(MyColorFunc(72, 122, 153, 1.0)!)
        colorArr.append(MyColorFunc(57, 114, 150, 1.0)!)
        colorArr.append(MyColorFunc(23, 150, 179, 1.0)!)
        colorArr.append(MyColorFunc(16, 122, 134, 1.0)!)
        colorArr.append(MyColorFunc(11, 96, 117, 1.0)!)
        colorArr.append(MyColorFunc(15, 112, 167, 1.0)!)
        colorArr.append(MyColorFunc(29, 57, 125, 1.0)!)
        colorArr.append(MyColorFunc(25, 59, 130, 1.0)!)
        colorArr.append(MyColorFunc(50, 76, 134, 1.0)!)
        colorArr.append(MyColorFunc(45, 54, 125, 1.0)!)
        colorArr.append(MyColorFunc(87, 104, 154, 1.0)!)
        colorArr.append(MyColorFunc(88, 110, 146, 1.0)!)
        colorArr.append(MyColorFunc(89, 104, 127, 1.0)!)
        colorArr.append(MyColorFunc(21, 77, 113, 1.0)!)
//        colorArr.append(MyColorFunc(9, 70, 107, 1.0)!)
//        colorArr.append(MyColorFunc(8, 76, 96, 1.0)!)
//        colorArr.append(MyColorFunc(6, 61, 89, 1.0)!)
        colorArr.append(MyColorFunc(23, 30, 58, 1.0)!)
        colorArr.append(MyColorFunc(26, 46, 79, 1.0)!)
        colorArr.append(MyColorFunc(58, 60, 86, 1.0)!)
        colorArr.append(MyColorFunc(23, 30, 52, 1.0)!)
        colorArr.append(MyColorFunc(101, 83, 137, 1.0)!)
        colorArr.append(MyColorFunc(110, 78, 142, 1.0)!)
        colorArr.append(MyColorFunc(191, 160, 176, 1.0)!)
        colorArr.append(MyColorFunc(162, 138, 184, 1.0)!)
//        colorArr.append(MyColorFunc(142, 120, 154, 1.0)!)
//        colorArr.append(MyColorFunc(109, 71, 118, 1.0)!)
//        colorArr.append(MyColorFunc(132, 63, 137, 1.0)!)
        colorArr.append(MyColorFunc(93, 34, 91, 1.0)!)
        colorArr.append(MyColorFunc(168, 148, 166, 1.0)!)
        colorArr.append(MyColorFunc(117, 28, 91, 1.0)!)
        colorArr.append(MyColorFunc(193, 100, 153, 1.0)!)
        colorArr.append(MyColorFunc(185, 116, 147, 1.0)!)
        colorArr.append(MyColorFunc(220, 201, 210, 1.0)!)
        colorArr.append(MyColorFunc(130, 115, 131, 1.0)!)
        return colorArr
    }
}

extension DataManager {
    func randomFilter(originalImg: UIImage) -> UIImage {
        if currentFitelrIndex == 3 {
            currentFitelrIndex = 0
            return originalImg
        }
        currentFitelrIndex += 1
 
        if let current = currentFitelrName {
            let list = filterNameList.filter {
                $0 != current
            }
            let name = list.randomElement()
            currentFitelrName = name
        } else {
            let name = filterNameList.randomElement()
            currentFitelrName = name
        }
        
        let resultImg = FilterDataTool.pictureProcessData(originalImg, matrixName: currentFitelrName ?? "")
        return resultImg
        
    }
}


extension DataManager {
    func loadJson<T: Codable>(_: T.Type, name: String, type: String = "json") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return try! JSONDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                debugPrint(error)
            }
        }
        return nil
    }
    
    func loadJson<T: Codable>(_:T.Type, path:String) -> T? {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            do {
                return try PropertyListDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func loadPlist<T: Codable>(_:T.Type, name:String, type:String = "plist") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            return loadJson(T.self, path: path)
        }
        return nil
    }
    
}



public func MyColorFunc(_ red:CGFloat,_ gren:CGFloat,_ blue:CGFloat,_ alpha:CGFloat) -> UIColor? {
    let color:UIColor = UIColor(red: red/255.0, green: gren/255.0, blue: blue/255.0, alpha: alpha)
    return color
}
