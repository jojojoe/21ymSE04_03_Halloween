//
//  HWymTextINputV.swift
//  HWymHalloWeen
//
//  Created by JOJO on 2021/10/19.
//

import UIKit
import SnapKit
import ZKProgressHUD

let maxLableCount: Int = 100
class HWymTextINputV: UIViewController {

    var cancelBtn: UIButton = UIButton.init(type: .custom)
    var doneBtn: UIButton = UIButton.init(type: .custom)
    
    var contentTextView: UITextView = UITextView.init()
    var cancelClickActionBlock: (()->Void)?
    var doneClickActionBlock: ((String, Bool)->Void)?
    
    var limitLabel: UILabel = UILabel.init(text: "0/\(maxLableCount)")
    
    
    
    // Public
    var contentText: String = "" {
        didSet {
            updateLimitTextLabel(contentText: contentText)
//            "Begin writing your story here"
            let defaultText = "DOUBLE TAP TO TEXT"
            if contentText == defaultText || contentText == "" {
                contentTextView.text = ""
//                contentTextView.placeholder = defaultText
            } else {
                contentTextView.text = contentText
                contentTextView.placeholder = ""
                
            }
            
        }
    }
    var isAddNew: Bool = false
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextView()
        setupTextViewNotification()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        contentTextView.text = "Halloween"
//        if contentTextView.text == "" {
//            contentTextView.text = "Halloween"
//            contentText = "Halloween"
//        }
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//            
//            self.contentTextView.placeholder = "Halloween"
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
 
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updatUI()
    }
}

extension HWymTextINputV {
    
    func updatUI() {
        
         
         
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        // blur
//        let blur = UIBlurEffect(style: .dark)
//        let effectView = UIVisualEffectView.init(effect: blur)
//        view.addSubview(effectView)
//        effectView.snp.makeConstraints {
//            $0.top.left.bottom.right.equalToSuperview()
//        }
        
        
        view.addSubview(cancelBtn)
        view.addSubview(doneBtn)
        
        
        cancelBtn.snp.makeConstraints {
            $0.width.equalTo(44)
            $0.height.equalTo(44)
            $0.left.equalToSuperview().offset(10)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        doneBtn.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(44)
            $0.height.equalTo(44)
            $0.centerY.equalTo(cancelBtn)
            $0.right.equalToSuperview().offset(-10)
        }
         
        
        
        cancelBtn.setImage(UIImage(named: "popup_close_ic"), for: .normal)
        cancelBtn.backgroundColor = UIColor.clear
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick(btn:)), for: .touchUpInside)
        doneBtn
            .image(UIImage(named: "text_done_ic"))
        
        doneBtn.backgroundColor = UIColor.clear
        doneBtn.addTarget(self, action: #selector(doneBtnClick(btn:)), for: .touchUpInside)
    }
    
    @objc
    func cancelBtnClick(btn: UIButton) {
        finishEdit()
        cancelClickActionBlock?()
    }
    
    @objc
    func doneBtnClick(btn: UIButton) {
        
        finishEdit()
        var str: String = contentTextView.text
        if str == "" {
            str = "DOUBLE TAP TO TEXT"
        }
        doneClickActionBlock?(str, isAddNew)

    }
    
    func setupTextView() {
        
        contentTextView.backgroundColor = .clear
        contentTextView.textColor = UIColor.white
        contentTextView.font = UIFont(name: "Creepster-Regular", size: 40)
        view.addSubview(contentTextView)
        contentTextView.delegate = self
        contentTextView.textAlignment = .left
        contentTextView.snp.makeConstraints {
            $0.left.equalTo(cancelBtn.snp.right)
            $0.right.equalTo(doneBtn.snp.left)
            $0.top.equalTo(cancelBtn.snp.bottom).offset(20)
            $0.height.equalTo(280)
        }

        
        limitLabel.textAlignment = .right
        limitLabel.font =  UIFont(name: "AvenirNext-Medium", size: 10)
        limitLabel.textColor = UIColor.white
        view.addSubview(limitLabel)
        limitLabel.snp.makeConstraints {
            $0.right.equalTo(contentTextView)
            $0.top.equalTo(contentTextView.snp.bottom).offset(10)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
    }
    
}

extension HWymTextINputV {
    func finishEdit() {
        contentTextView.resignFirstResponder()
    }
    
    func startEdit() {
        contentTextView.becomeFirstResponder()
    }

    func updateLimitTextLabel(contentText: String) {
        
        limitLabel.text = "\(contentText.count)/\(maxLableCount)"
        if contentText.count >= maxLableCount {
            limitLabel.textColor = UIColor.white
            showCountLimitAlert()
        } else {
            limitLabel.textColor = UIColor.white
        }
    }

}
 

extension HWymTextINputV: UITextViewDelegate {
    
    func showCountLimitAlert() {
        if !ZKProgressHUD.isShowing {
            ZKProgressHUD.showInfo("No more than \(maxLableCount) characters.", maskStyle: nil, onlyOnceFont: nil, autoDismissDelay: 2, completion: nil)
        }
        
    }
    
    func setupTextViewNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(textViewNotifitionAction), name: UITextView.textDidChangeNotification, object: nil);
    }
    @objc
    func textViewNotifitionAction(userInfo:NSNotification){
        guard let textView = userInfo.object as? UITextView else { return }
        if textView.text.count >= maxLableCount {
            let selectRange = textView.markedTextRange
            if let selectRange = selectRange {
                let position =  textView.position(from: (selectRange.start), offset: 0)
                if (position != nil) {
                    // 高亮部分不进行截取，否则中文输入会把高亮区域的拼音强制截取为字母，等高亮取消后再计算字符总数并截取
                    return
                }

            }
            textView.text = String(textView.text[..<String.Index(encodedOffset: maxLableCount)])

            // 对于粘贴文字的case，粘贴结束后若超出字数限制，则让光标移动到末尾处
            textView.selectedRange = NSRange(location: textView.text.count, length: 0)
        }
        
        contentText = textView.text
        
    }
     
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // range: The range of characters to be replaced.(location、count)
        // 高亮控制
        let selectedRange = textView.markedTextRange
        if let selectedRange = selectedRange {
            let position =  textView.position(from: (selectedRange.start), offset: 0)
            if position != nil {
                let startOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
                let endOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange.end)
                let offsetRange = NSMakeRange(startOffset, endOffset - startOffset) // 高亮部分起始位置
                if offsetRange.location < maxLableCount {
                    // 高亮部分先不进行字数统计
                    return true
                } else {
                    debugPrint("字数已达上限")
                    return false
                }
            }
        }

        // 在最末添加
        if range.location >= maxLableCount {
            debugPrint("字数已达上限")
            return false
        }

        // 在其他位置添加
        if textView.text.count >= maxLableCount && range.length <  text.count {
            debugPrint("字数已达上限")
            return false
        }

        return true
    }
    
}

