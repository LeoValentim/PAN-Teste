//
//  UIViewControllerExtension.swift
//  carro66
//
//  Created by Megaleios DEV on 26/02/18.
//  Copyright © 2018 Megaleios. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showErrorMessage(_ error: Error?, complition: (() -> Void)? = nil) {
        if let urlError = error as? URLError {
            if urlError.code == URLError.Code.notConnectedToInternet
                || urlError.code == URLError.Code.networkConnectionLost
                || urlError.code == URLError.Code.cannotConnectToHost
                || urlError.code == URLError.Code.secureConnectionFailed {
                
                let alert = UIAlertController(title: "Erro de conexão!", message: "Tente novamente mais tarde.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {_ in
                    complition?()
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
        } else if let cocoaError = error as? CocoaError {
            if cocoaError.code == .coderInvalidValue
                || cocoaError.code == .coderValueNotFound {
                
                let alert = UIAlertController(title: "Erro de conexão!", message: "Tente novamente mais tarde.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {_ in
                    complition?()
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        
        let alert = UIAlertController(title: "Ocorreu um erro!", message: "Tente novamente mais tarde.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {_ in
            complition?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

