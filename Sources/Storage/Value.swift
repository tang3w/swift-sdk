//
//  LCValue.swift
//  LeanCloud
//
//  Created by Tang Tianyong on 2/27/16.
//  Copyright © 2016 LeanCloud. All rights reserved.
//

import Foundation

/**
 Abstract data type.

 All LeanCloud data types must confirm this protocol.
 */
@objc public protocol LCValue: NSObjectProtocol, NSCoding, NSCopying {
    /**
     The JSON representation.
     */
    var jsonValue: AnyObject { get }

    /**
     The pretty description.
     */
    var jsonString: String { get }
}

/**
 Extension of LCValue.

 By convention, all types that confirm `LCValue` must also confirm `LCValueExtension`.
 */
protocol LCValueExtension {
    /**
     The LCON (LeanCloud Object Notation) representation.

     For JSON-compatible objects, such as string, array, etc., LCON value is the same as JSON value.

     However, some types might have different representations, or even have no LCON value.
     For example, when an object has not been saved, its LCON value is nil.
     */
    var lconValue: AnyObject? { get }

    /**
     The raw value of current value.

     For JSON-compatible objects, such as string, array, etc., raw value is the value of corresponding Swift built-in type.
     For some objects of other types, such as `LCObject`, `LCACL` etc., raw value is itself.
     */
    var rawValue: LCValueConvertible { get }

    /**
     Create an instance of current type.

     This method exists because some data types cannot be instantiated externally.

     - returns: An instance of current type.
     */
    static func instance() throws -> LCValue

    // MARK: Enumeration

    /**
     Iterate children by a closure.

     - parameter body: The iterator closure.
     */
    func forEachChild(_ body: (_ child: LCValue) -> Void)

    // MARK: Arithmetic

    /**
     Add an object.

     - parameter other: The object to be added, aka the addend.

     - returns: The sum of addition.
     */
    func add(_ other: LCValue) throws -> LCValue

    /**
     Concatenate an object with unique option.

     - parameter other:  The object to be concatenated.
     - parameter unique: Whether to concatenate with unique or not.

        If `unique` is true, for each element in `other`, if current object has already included the element, do nothing.
        Otherwise, the element will always be appended.

     - returns: The concatenation result.
     */
    func concatenate(_ other: LCValue, unique: Bool) throws -> LCValue

    /**
     Calculate difference with other.

     - parameter other: The object to differ.

     - returns: The difference result.
     */
    func differ(_ other: LCValue) throws -> LCValue
}

/**
 Convertible protocol for `LCValue`.
 */
public protocol LCValueConvertible {
    /**
     Get the `LCValue` value for current object.
     */
    var lcValue: LCValue { get }
}

/**
 Convertible protocol for `LCNull`.
 */
public protocol LCNullConvertible: LCValueConvertible {
    var lcNull: LCNull { get }
}

/**
 Convertible protocol for `LCNumber`.
 */
public protocol LCNumberConvertible: LCValueConvertible {
    var lcNumber: LCNumber { get }
}

/**
 Convertible protocol for `LCBool`.
 */
public protocol LCBoolConvertible: LCValueConvertible {
    var lcBool: LCBool { get }
}

/**
 Convertible protocol for `LCString`.
 */
public protocol LCStringConvertible: LCValueConvertible {
    var lcString: LCString { get }
}

/**
 Convertible protocol for `LCArray`.
 */
public protocol LCArrayConvertible: LCValueConvertible {
    var lcArray: LCArray { get }
}

/**
 Convertible protocol for `LCDictionary`.
 */
public protocol LCDictionaryConvertible: LCValueConvertible {
    var lcDictionary: LCDictionary { get }
}

/**
 Convertible protocol for `LCData`.
 */
public protocol LCDataConvertible: LCValueConvertible {
    var lcData: LCData { get }
}

/**
 Convertible protocol for `LCDate`.
 */
public protocol LCDateConvertible: LCValueConvertible {
    var lcDate: LCDate { get }
}

extension NSNull: LCNullConvertible {
    public var lcValue: LCValue {
        return lcNull
    }

    public var lcNull: LCNull {
        return LCNull()
    }
}

extension Int: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension UInt: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension Int8: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension UInt8: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension Int16: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension UInt16: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension Int32: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension UInt32: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension Int64: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension UInt64: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension Float: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension Double: LCNumberConvertible {
    public var lcValue: LCValue {
        return lcNumber
    }

    public var lcNumber: LCNumber {
        return LCNumber(Double(self))
    }
}

extension Bool: LCBoolConvertible {
    public var lcValue: LCValue {
        return lcBool
    }

    public var lcBool: LCBool {
        return LCBool(self)
    }
}

extension NSNumber: LCNumberConvertible, LCBoolConvertible {
    public var lcValue: LCValue {
        return try! ObjectProfiler.object(jsonValue: self)
    }

    public var lcNumber: LCNumber {
        return LCNumber(self.doubleValue)
    }

    public var lcBool: LCBool {
        return LCBool(self.boolValue)
    }
}

extension String: LCStringConvertible {
    public var lcValue: LCValue {
        return lcString
    }

    public var lcString: LCString {
        return LCString(self)
    }
}

extension NSString: LCStringConvertible {
    public var lcValue: LCValue {
        return lcString
    }

    public var lcString: LCString {
        return LCString(String(self))
    }
}

extension Array: LCArrayConvertible {
    public var lcValue: LCValue {
        return lcArray
    }

    public var lcArray: LCArray {
        let value = try! map { element -> LCValue in
            guard let element = element as? LCValueConvertible else {
                throw LCError(code: .invalidType, reason: "Element is not LCValue-convertible.", userInfo: nil)
            }
            return element.lcValue
        }

        return LCArray(value)
    }
}

extension NSArray: LCArrayConvertible {
    public var lcValue: LCValue {
        return lcArray
    }

    public var lcArray: LCArray {
        return (self as Array).lcArray
    }
}

extension Dictionary: LCDictionaryConvertible {
    public var lcValue: LCValue {
        return lcDictionary
    }

    public var lcDictionary: LCDictionary {
        let elements = try! map { (key, value) -> (String, LCValue) in
            guard let key = key as? String else {
                throw LCError(code: .invalidType, reason: "Key is not a string.", userInfo: nil)
            }
            guard let value = value as? LCValueConvertible else {
                throw LCError(code: .invalidType, reason: "Value is not LCValue-convertible.", userInfo: nil)
            }
            return (key, value.lcValue)
        }
        let value = [String: LCValue](elements: elements)

        return LCDictionary(value)
    }
}

extension NSDictionary: LCDictionaryConvertible {
    public var lcValue: LCValue {
        return lcDictionary
    }

    public var lcDictionary: LCDictionary {
        return (self as Dictionary).lcDictionary
    }
}

extension Data: LCDataConvertible {
    public var lcValue: LCValue {
        return lcData
    }

    public var lcData: LCData {
        return LCData(self)
    }
}

extension NSData: LCDataConvertible {
    public var lcValue: LCValue {
        return lcData
    }

    public var lcData: LCData {
        return LCData(self as Data)
    }
}

extension Date: LCDateConvertible {
    public var lcValue: LCValue {
        return lcDate
    }

    public var lcDate: LCDate {
        return LCDate(self)
    }
}

extension NSDate: LCDateConvertible {
    public var lcValue: LCValue {
        return lcDate
    }

    public var lcDate: LCDate {
        return LCDate(self as Date)
    }
}

extension LCNull: LCValueConvertible, LCNullConvertible {
    public var lcValue: LCValue {
        return self
    }

    public var lcNull: LCNull {
        return self
    }
}

extension LCNumber: LCValueConvertible, LCNumberConvertible {
    public var lcValue: LCValue {
        return self
    }

    public var lcNumber: LCNumber {
        return self
    }
}

extension LCBool: LCValueConvertible, LCBoolConvertible {
    public var lcValue: LCValue {
        return self
    }

    public var lcBool: LCBool {
        return self
    }
}

extension LCString: LCValueConvertible, LCStringConvertible {
    public var lcValue: LCValue {
        return self
    }

    public var lcString: LCString {
        return self
    }
}

extension LCArray: LCValueConvertible, LCArrayConvertible {
    public var lcValue: LCValue {
        return self
    }

    public var lcArray: LCArray {
        return self
    }
}

extension LCDictionary: LCValueConvertible, LCDictionaryConvertible {
    public var lcValue: LCValue {
        return self
    }

    public var lcDictionary: LCDictionary {
        return self
    }
}

extension LCObject: LCValueConvertible {
    public var lcValue: LCValue {
        return self
    }
}

extension LCRelation: LCValueConvertible {
    public var lcValue: LCValue {
        return self
    }
}

extension LCGeoPoint: LCValueConvertible {
    public var lcValue: LCValue {
        return self
    }
}

extension LCData: LCValueConvertible, LCDataConvertible {
    public var lcValue: LCValue {
        return self
    }

    public var lcData: LCData {
        return self
    }
}

extension LCDate: LCValueConvertible, LCDateConvertible {
    public var lcValue: LCValue {
        return self
    }

    public var lcDate: LCDate {
        return self
    }
}

extension LCACL: LCValueConvertible {
    public var lcValue: LCValue {
        return self
    }
}
