//
//  ViewController.swift
//  TableViewAutoSizing
//
//  Created by John Nik on 1/29/18.
//  Copyright © 2018 johnik703. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.text = "Here is some default text that we want to show and it might be a couple of lines that are word wrapped"
        tv.backgroundColor = .lightGray
        tv.font = UIFont.preferredFont(forTextStyle: .headline)
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        return tv
    }()
    
    lazy var inputContainerView: ChatInputContainerView = {
        let containerView = ChatInputContainerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        containerView.viewController = self
        
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(textView)
        
        [
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 50)
            ].forEach{ $0.isActive = true }
        
        textViewDidChange(textView)
    }
    
    override var inputAccessoryView: UIView? {
        
        get {
            return inputContainerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    @objc func handleSend() {
        textView.text = inputContainerView.textView.text
        inputContainerView.textView.text = nil
        textViewDidChange(textView)
    }

}

extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}

