//
//  ViewController.swift
//  Keyboard
//
//  Created by yuki takei on 2017/09/18.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit


//ここを最初に設定。まずpdfのやり方をやって見る。エラーでても、試しに一回実行してみること。慌てない。
import AGEmojiKeyboard


//↓にAGEmojiKeyboardViewDelegate, AGEmojiKeyboardViewDataSourceを設定
class ViewController: UIViewController , AGEmojiKeyboardViewDelegate, AGEmojiKeyboardViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var textfield: UITextField!
    
    //最初に呼ばれるとこ
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ここで絵文字キーボードを作る
        let emojiKeyboard = AGEmojiKeyboardView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 216), dataSource: self)
        emojiKeyboard?.autoresizingMask = UIViewAutoresizing.flexibleWidth
        emojiKeyboard?.dataSource = self
        emojiKeyboard?.delegate = self
        emojiKeyboard?.backgroundColor = UIColor.white
        emojiKeyboard?.segmentsBar.backgroundColor = UIColor.black
        emojiKeyboard?.segmentsBar.tintColor = UIColor.green
        
        
        //絵文字のキーボードをtextfieldで使うよって設定。
        self.textfield.inputView = emojiKeyboard
        self.textfield.becomeFirstResponder()
    }


    /*
     キーボードしまうやつ。↓見ながらやってみて。label置くみたいにViewControllerにTapGestureRecognizer置けばOK それができたら関連付け。メッセの画像も参考に。
     http://qiita.com/sasagin/items/f2d5e8cb35e3b7091942
     */
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //ここからまとめてコピペ-----------------------------------------------------------------------------------
    
    //MARK: - AGEmojiKeyboardViewDataSource
    //AGEmojiKeyboardViewDataSource キーボードの初期設定するところ
    func emojiKeyboardView(_ emojiKeyboardView: AGEmojiKeyboardView!, imageForSelectedCategory category: AGEmojiKeyboardViewCategoryImage) -> UIImage! {
        
        return emojiSilhouette(category: category)
    }
    
    func emojiKeyboardView(_ emojiKeyboardView: AGEmojiKeyboardView!, imageForNonSelectedCategory category: AGEmojiKeyboardViewCategoryImage) -> UIImage! {
        
        return emojiSilhouette(category: category)
    }
    
    //ここで絵文字キーボードのシルエット
    func emojiSilhouette(category: AGEmojiKeyboardViewCategoryImage) -> UIImage!{
        var emojiImage:UIImage! = UIImage()
        
        switch category {
        case .recent:
            emojiImage = "💭".image()

        case .face:
            emojiImage = "👷".image()
            
        case .bell:
            emojiImage = "🔔".image()
            
        case .flower:
            emojiImage = "🐱".image()
            
        case .car:
            emojiImage = "🚗".image()
            
        case .characters:
            emojiImage = "♣️".image()
        default:
            break
        }
        
        return emojiImage

    }
    
    func backSpaceButtonImage(for emojiKeyboardView: AGEmojiKeyboardView!) -> UIImage! {
        return UIImage()
    }
    
    
    //MARK: - AGEmojiKeyboardViewDelegate
    //キーボードの動きを見るところ。ここでtextfieldとかに文字を入れる
    func emojiKeyBoardView(_ emojiKeyBoardView: AGEmojiKeyboardView!, didUseEmoji emoji: String!) {
        self.textfield.text = emoji
    }
    
    //ここも必ずかくこと。空っぽでもこのメソッドないとエラーでる
    func emojiKeyBoardViewDidPressBackSpace(_ emojiKeyBoardView: AGEmojiKeyboardView!) {
        
    }
    
    //ここまで-----------------------------------------------------------------------------------

}


//あと、Classの外側に以下コピペ

//絵文字を画像に変えるコード。上手く使えば、mapのピンを全部絵文字にできる。
extension String {
    func image() -> UIImage {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
