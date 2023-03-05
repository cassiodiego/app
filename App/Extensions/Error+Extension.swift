//
//  Error+Extension.swift
//  Authenticator
//
//  Created by Cassio Diego T. Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego T. Campos. All rights reserved.
//

import Foundation

extension NSError: Identifiable {
    public var id: Int { code }
}
