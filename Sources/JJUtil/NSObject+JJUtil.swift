//
//  File.swift
//  
//
//  Created by jingjing on 1/28/20.
//

import Foundation

extension NSObject {
    public static var className: String { String(describing: self) }
    public static var reuseIdentifier: String { className + "Identifier" }
}
