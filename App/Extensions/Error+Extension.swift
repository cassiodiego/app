//
//  Error+Extension.swift
//  App
//
//  Created by Cassio Diego Tavares Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego Tavares Campos. All rights reserved.
//

import Foundation

extension NSError: @retroactive Identifiable {
    public var id: Int { code }
}
