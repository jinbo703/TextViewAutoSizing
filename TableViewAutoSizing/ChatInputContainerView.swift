//
//  ChatInputContainerView.swift
//  TableViewAutoSizing
//
//  Created by John Nik on 1/29/18.
//  Copyright © 2018 johnik703. All rights reserved.
//

import UIKit

class ChatInputContainerView: UIView {
    
    var viewController: ViewController? {
        
        didSet {
            sendButton.addTarget(viewController, action: #selector(viewController?.handleSend), for: .touchUpInside)
        }
    }
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.text = "Enter message here"
        tv.font = UIFont.preferredFont(forTextStyle: .headline)
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        return tv
    }()
    
    let sendButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
        
    }()
    
    let containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(containerView)
        
        [
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ].forEach{ $0.isActive = true }
        
        containerView.addSubview(sendButton)
        
        [
            sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor)
            ].forEach{ $0.isActive = true }
        
        containerView.addSubview(textView)
        
        [
            textView.leftAnchor.constraint(equalTo: leftAnchor),
            textView.rightAnchor.constraint(equalTo: sendButton.leftAnchor),
            textView.centerYAnchor.constraint(equalTo: centerYAnchor),
            textView.heightAnchor.constraint(equalTo: heightAnchor)
            ].forEach{ $0.isActive = true }
        
        let seperatorLineView = UIView()
        seperatorLineView.backgroundColor = UIColor.black
        seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(seperatorLineView)
        
        seperatorLineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        seperatorLineView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        seperatorLineView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        seperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatInputContainerView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width - 50, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
