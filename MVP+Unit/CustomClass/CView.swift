//
//  CView.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import UIKit

class CView: UIView {
    
    func createView(
        cornerRadius: CGFloat
    ) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
