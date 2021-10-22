//
//  HWymMainVC.swift
//  HWymHalloWeen
//
//  Created by JOJO on 2021/10/18.
//

import UIKit
import SnapKit
import Photos
import YPImagePicker
import DeviceKit

class HWymMainVC: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    
    func setupView() {
        view
            .backgroundColor(UIColor.white)
        //
        let bgImgV = UIImageView()
        bgImgV
            .image("hallween_home_bg_pic")
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: view)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        let settingBtn = UIButton(type: .custom)
        settingBtn
            .image(UIImage(named: "home_setting_ic"))
            .adhere(toSuperview: view)
        settingBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.right.equalTo(-10)
            $0.width.height.equalTo(44)
        }
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender: )), for: .touchUpInside)
        //
        let storeBtn = UIButton(type: .custom)
        storeBtn
            .image(UIImage(named: "home_store_ic"))
            .adhere(toSuperview: view)
        storeBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        storeBtn.addTarget(self, action: #selector(storeBtnClick(sender: )), for: .touchUpInside)
        //
        let createnowBtn = UIButton(type: .custom)
        createnowBtn
            .backgroundImage(UIImage(named: "home_start_bg_ic"))
            .adhere(toSuperview: view)
        createnowBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
            $0.width.equalTo(540/2)
            $0.height.equalTo(166/2)
            
        }
        createnowBtn.addTarget(self, action: #selector(createnowBtnClick(sender: )), for: .touchUpInside)
        //
        let createnowLabel = UILabel()
        createnowLabel
            .text("Create Now")
            .color(UIColor.white)
            .fontName(24, "AvenirNext-Bold")
            .adhere(toSuperview: view)
        createnowLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(createnowBtn.snp.top).offset(10)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        let coverImgV = UIImageView()
        coverImgV
            .image("hallween_home_title_pic")
            .backgroundColor(UIColor.clear)
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: view)
        
        if Device.current.diagonal >= 5.8 && Device.current.diagonal <= 6.7 {
            coverImgV.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(storeBtn.snp.bottom).offset(98)
                $0.left.equalTo(40)
                $0.height.equalTo(270)
            }
        } else {
            coverImgV.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(storeBtn.snp.bottom).offset(70)
                $0.left.equalTo(40)
                $0.height.equalTo(270)
            }
        }
        
        
        //
        let coverImgV2 = UIImageView()
        coverImgV2
            .image("make_up_editor_pic")
            .backgroundColor(UIColor.clear)
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: view)
        coverImgV2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(coverImgV.snp.bottom).offset(10)
            $0.left.equalTo(40)
            $0.height.equalTo(32)
        }
        //
        let coverImgV3 = UIImageView()
        coverImgV3
            .image("welcome_to_ic")
            .backgroundColor(UIColor.clear)
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: view)
        coverImgV3.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(coverImgV.snp.top).offset(10)
            $0.left.equalTo(40)
            $0.height.equalTo(32)
        }
        //
        
        
    }

    @objc func settingBtnClick(sender: UIButton) {
        let vc = HWymSettingVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func storeBtnClick(sender: UIButton) {
        let vc = HWymStoreVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func createnowBtnClick(sender: UIButton) {
        checkAlbumAuthorization()
        
        
        
    }
    
}


extension HWymMainVC: UIImagePickerControllerDelegate {
    
    func checkAlbumAuthorization() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        self.presentPhotoPickerController()
                    }
                case .limited:
                    DispatchQueue.main.async {
                        self.presentLimitedPhotoPickerController()
                    }
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized {
                        DispatchQueue.main.async {
                            self.presentPhotoPickerController()
                        }
                    } else if status == PHAuthorizationStatus.limited {
                        DispatchQueue.main.async {
                            self.presentLimitedPhotoPickerController()
                        }
                    }
                case .denied:
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
                    
                case .restricted:
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
                default: break
                }
            }
        }
    }
    
    func presentLimitedPhotoPickerController() {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 1
        config.screens = [.library]
        config.library.defaultMultipleSelection = false
        config.library.skipSelectionsGallery = true
        config.showsPhotoFilters = false
        config.library.preselectedItems = nil
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            var imgs: [UIImage] = []
            for item in items {
                switch item {
                case .photo(let photo):
                    if let img = photo.image.scaled(toWidth: 1200) {
                        imgs.append(img)
                    }
                    print(photo)
                case .video(let video):
                    print(video)
                }
            }
            picker.dismiss(animated: true, completion: nil)
            if !cancelled {
                if let image = imgs.first {
                    self.showEditVC(image: image)
                }
            }
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    
    
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true, completion: nil)
//        var imgList: [UIImage] = []
//
//        for result in results {
//            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
//                if let image = object as? UIImage {
//                    DispatchQueue.main.async {
//                        // Use UIImage
//                        print("Selected image: \(image)")
//                        imgList.append(image)
//                    }
//                }
//            })
//        }
//        if let image = imgList.first {
//            self.showEditVC(image: image)
//        }
//    }
    
 
    func presentPhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.allowsEditing = false
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.showEditVC(image: image)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.showEditVC(image: image)
        }

    }
//
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showEditVC(image: UIImage) {
        DispatchQueue.main.async {
            [weak self] in
            guard let `self` = self else {return}
            let vc = HWymEditVC(originalImg: image)
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }

    
    
}
