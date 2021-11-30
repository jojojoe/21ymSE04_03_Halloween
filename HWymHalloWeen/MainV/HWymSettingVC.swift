//
//  HWymSettingVC.swift
//  HWymHalloWeen
//
//  Created by JOJO on 2021/10/18.
//

import UIKit
import SwifterSwift
import MessageUI

class HWymSettingVC: UIViewController {

    let privacyBtn = UIButton(type: .custom)
    let termsBtn = UIButton(type: .custom)
    let feedbackBtn = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    

    func setupView() {
        view.backgroundColor(UIColor(hexString: "#1C1C1C")!)
        view.clipsToBounds()
        //
        let backBtn = UIButton(type: .custom)
        backBtn
            .image(UIImage(named: "edit_pic_back"))
            .adhere(toSuperview: view)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        
        let topLabel = UILabel()
        topLabel
            .text("Setting")
            .color(UIColor(hexString: "#EB6601")!)
            .fontName(16, "AvenirNext-Medium")
            .adhere(toSuperview: view)
        topLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backBtn.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        //
        feedbackBtn
            .backgroundImage(UIImage(named: "setting_feedback_bg"))
            .title("Feedback")
            .titleColor(UIColor.black)
            .font(18, "AvenirNext-Bold")
            .adhere(toSuperview: view)
        
        feedbackBtn.snp.makeConstraints {
            $0.width.equalTo(566/2)
            $0.height.equalTo(122/2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topLabel.snp.bottom).offset(102)
        }
        feedbackBtn.addTarget(self, action: #selector(feedbackBtnClick(sender:)), for: .touchUpInside)
        //
        privacyBtn
            .backgroundImage(UIImage(named: "setting_feedback_bg"))
            .title("Privacy Policy")
            .titleColor(UIColor.black)
            .font(18, "AvenirNext-Bold")
            .adhere(toSuperview: view)
        
        privacyBtn.snp.makeConstraints {
            $0.width.equalTo(566/2)
            $0.height.equalTo(122/2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(feedbackBtn.snp.bottom).offset(50)
        }
        privacyBtn.addTarget(self, action: #selector(privacyBtnClick(sender:)), for: .touchUpInside)
        //
        termsBtn
            .backgroundImage(UIImage(named: "setting_feedback_bg"))
            .title("Terms of use")
            .titleColor(UIColor.black)
            .font(18, "AvenirNext-Bold")
            .adhere(toSuperview: view)
        termsBtn.snp.makeConstraints {
            $0.width.equalTo(566/2)
            $0.height.equalTo(122/2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(privacyBtn.snp.bottom).offset(50)
        }
        termsBtn.addTarget(self, action: #selector(termsBtnClick(sender:)), for: .touchUpInside)
        
        
        
    }
    
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func privacyBtnClick(sender: UIButton) {
//        UIApplication.shared.openURL(url: PrivacyPolicyURLStr)
        let vc = HighLightingViewController(contentUrl: nil)
        vc.pushSaferiVC(url: PrivacyPolicyURLStr)
    }
    
    @objc func termsBtnClick(sender: UIButton) {
//        UIApplication.shared.openURL(url: TermsofuseURLStr)
        let vc = HighLightingViewController(contentUrl: nil)
        vc.pushSaferiVC(url: TermsofuseURLStr)
    }
    
    @objc func feedbackBtnClick(sender: UIButton) {
        feedback()
    }
    
}

extension HWymSettingVC: MFMailComposeViewControllerDelegate {
   func feedback() {
       //首先要判断设备具不具备发送邮件功能
       if MFMailComposeViewController.canSendMail(){
           //获取系统版本号
           let systemVersion = UIDevice.current.systemVersion
           let modelName = UIDevice.current.modelName
           
           let infoDic = Bundle.main.infoDictionary
           // 获取App的版本号
           let appVersion = infoDic?["CFBundleShortVersionString"] ?? "8.8.8"
           // 获取App的名称
           let appName = "\(AppName)"

           
           let controller = MFMailComposeViewController()
           //设置代理
           controller.mailComposeDelegate = self
           //设置主题
           controller.setSubject("\(appName) Feedback")
           //设置收件人
           // FIXME: feed back email
           controller.setToRecipients([feedbackEmail])
           //设置邮件正文内容（支持html）
        controller.setMessageBody("\n\n\nSystem Version：\(systemVersion)\n Device Name：\(modelName)\n App Name：\(appName)\n App Version：\(appVersion )", isHTML: false)
           
           //打开界面
        self.present(controller, animated: true, completion: nil)
       }else{
           HUD.error("The device doesn't support email")
       }
   }
   
   //发送邮件代理方法
   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       controller.dismiss(animated: true, completion: nil)
   }
}
