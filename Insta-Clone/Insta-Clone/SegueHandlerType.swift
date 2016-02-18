//
//  SegueHandlerType.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/18/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import UIKit

protocol SegueHandlerType
{
    typealias SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String
{
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?)
    {
        self.performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier
    {
        guard let identifier = segue.identifier, segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            fatalError() }
        return segueIdentifier
    }
    
}
