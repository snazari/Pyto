//
//  SceneDelegate+ViewController.swift
//  Pyto
//
//  Created by Emma Labbé on 02-07-20.
//  Copyright © 2018-2021 Emma Labbé. All rights reserved.
//

import UIKit

// Helpers for showing View controllers in a new window.

extension SceneDelegate {
    
    /// A View controller to present in a new created scene.
    static var viewControllerToShow: UIViewController?
    
    /// Code called after `viewControllerToShow` is shown.
    static var viewControllerDidShow: (() -> Void)?
    
    /// RIP Memory.
    static var windows = [UIWindow]()
    
    /// A View controller to show in a new window.
    @available(iOS 13.0, *)
    class ViewController: UIViewController {
        
        var justShown = true
        
        var viewControllerToPresent: UIViewController?
        
        var sceneSession: UISceneSession?
        
        var completion: (() -> Void)?
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            if let navVC = viewControllerToPresent as? UINavigationController, let editor = navVC.viewControllers.first as? EditorSplitViewController {
                editor.editor?.setupToolbarIfNeeded(windowScene: view.window?.windowScene)
            }
            
            if justShown, let vc = viewControllerToPresent {
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: { [weak self] in
                    self?.completion?()
                })
            } else if let session = sceneSession {
                UIApplication.shared.requestSceneSessionDestruction(session, options: nil, errorHandler: nil)
            }
            justShown = false            
        }
    }
}
