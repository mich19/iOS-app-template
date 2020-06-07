//
//  Spinner.swift
//  iOS-app-template
//
//  Created by Michel Franco Téllez on 06/06/20.
//  Copyright © 2020 MichelFranco. All rights reserved.
//

import UIKit

class Spinner: UIView, CAAnimationDelegate {

    private lazy var circularLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 5.0
        layer.fillColor = nil
        return layer
    }()
    
    private lazy var inAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        return animation
    }()
    
    private lazy var outAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        return animation
    }()
    
    private lazy var rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue = 2.0 * .pi
        animation.duration = 2.0
        animation.repeatCount = MAXFLOAT
        return animation
    }()
    
    var color: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(circularLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareAnimation()
    }
    
    private func prepareAnimation() {
        let pi2: CGFloat = .pi / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circularLayer.lineWidth / 2
        let arcPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: pi2, endAngle: pi2 + (2 * .pi), clockwise: true)
        
        circularLayer.position = center
        circularLayer.path = arcPath.cgPath
        
        animate()
        
        circularLayer.add(rotationAnimation, forKey: "rotateAnimation")
    }
    
    private func animate() {
        let animationKey = "strokeAnimation"
        circularLayer.removeAnimation(forKey: animationKey)
        if let color = self.color {
            circularLayer.strokeColor = color.cgColor
        } else {
            circularLayer.strokeColor = tintColor.cgColor
        }
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.0 + outAnimation.beginTime
        strokeAnimationGroup.repeatCount = 1
        strokeAnimationGroup.animations = [inAnimation, outAnimation]
        strokeAnimationGroup.delegate = self
        
        circularLayer.add(strokeAnimationGroup, forKey: animationKey)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animate()
        }
    }
    
}
