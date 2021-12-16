//
//  DateValueTransformer.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import Foundation

@objc(DateValueTransformer)
public final class DateValueTransformer: ValueTransformer {
    // MARK: - Functions
    
    override public class func transformedValueClass() -> AnyClass {
        NSArray.self
    }
    
    public override class func allowsReverseTransformation() -> Bool {
        true
    }
    
    public override func transformedValue(_ value: Any?) -> Any? {
        guard let dates = value as? NSArray else {
            return nil
        }
        
        do {
            return try NSKeyedArchiver.archivedData(
                withRootObject: dates,
                requiringSecureCoding: true
            )
        } catch {
            print("DateValueTransformer: - transformedValue error \(error.localizedDescription)")
            return nil
        }
    }
    
    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        
        do {
            return try NSKeyedUnarchiver.unarchivedObject(
                ofClasses: [
                    NSArray.self,
                    NSData.self,
                    NSString.self,
                ],
                from: data
            )
        } catch {
            print("DateValueTransformer: - reversetTransformedValue error \(error.localizedDescription)")
            return nil
        }
    }
}
