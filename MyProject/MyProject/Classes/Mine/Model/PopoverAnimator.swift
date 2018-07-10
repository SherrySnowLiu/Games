//
//  PopoverAnimator.swift
//  MyProject
//
//  Created by Sherry on 2018/7/9.
//  Copyright © 2018年 Sherry. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
    
    ///展现的视图的大小
    var presentFrame:CGRect?
    ///记录当前是否打开还是关闭
    var isPresent:Bool = false
    //返回动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    ///展开关闭
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent { //展开
            //拿到展开的视图
            let toView = transitionContext.view(forKey: .to)
            toView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            transitionContext.containerView.addSubview(toView!)
            //执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView?.transform = .identity
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }else{ //关闭
            //拿到关闭的视图
            let fromView = transitionContext.view(forKey: .from)
            //执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                //关闭
                fromView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            }) { (_) in
                transitionContext.completeTransition(true)
            }
            
        }
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = MyPresentationController(presentedViewController: presented, presenting: presenting)
        pc.presentFrame = presentFrame!
        return pc
    }
    //消失动画，告诉系统是来负责 modal 的消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
    //展开动画，只要实现了这个方法，系统默认的动画就消失了，所有设置都需要我们自己实现
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }

}
