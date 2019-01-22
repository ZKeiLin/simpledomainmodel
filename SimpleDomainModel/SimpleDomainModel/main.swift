//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
/*
Acceptable currencies are
 "USD",
 "GBP" (British pounds),
 "EUR" (Euro) and
 "CAN" (Canadian dollars, also known in the US as "funny money").
make sure to include code to reject unknown currencies

 Money should also have three methods, convert, which takes a currency name as a parameter and returns
 a new Money that contains the converted amount,
 
 1 USD = .5 GBP / 2 USD = 1 GBP
 
 1 USD = 1.5 EUR / 2 USD = 3 EUR
 
 1 USD = 1.25 CAN / 4 USD = 5 CAN
 

 */
public struct Money {
    public var amount : Int
    public var currency : String
    private var currencyRatio = ["USD": 1.0, "GBP": 0.5, "EUR" : 1.5, "CAN" : 1.25]
    init(amount: Int, currency : String) {
        if  !currencyRatio.keys.contains(currency) {
            print("Unknown Currencies")
            self.amount = -1
            self.currency = ""
        } else {
            self.amount = amount
            self.currency = currency
        }
    }
    
    public func convert(_ to: String) -> Money {
        let result = Int(Double(self.amount) / self.currencyRatio[self.currency]! * self.currencyRatio[to]!)
        return Money(amount: result, currency: to)
    }

    public func add(_ to: Money) -> Money {
        var curMoney = to
        if to.currency != self.currency {
            curMoney = self.convert(to.currency)
        }
        return Money(amount: to.amount + curMoney.amount, currency: to.currency)
    }
    public func subtract(_ from: Money) -> Money {
        var curMoney = from
        if from.currency != self.currency {
            curMoney = self.convert(from.currency)
        }
        return Money(amount: from.amount - curMoney.amount, currency: from.currency)
    }
}

////////////////////////////////////
// Job
//
//open class Job {
//  fileprivate var title : String
//  fileprivate var type : JobType
//
//  public enum JobType {
//    case Hourly(Double)
//    case Salary(Int)
//  }
//
//  public init(title : String, type : JobType) {
//  }
//
//  open func calculateIncome(_ hours: Int) -> Int {
//  }
//
//  open func raise(_ amt : Double) {
//  }
//}

////////////////////////////////////
// Person
//
//open class Person {
//  open var firstName : String = ""
//  open var lastName : String = ""
//  open var age : Int = 0
//
//  fileprivate var _job : Job? = nil
//  open var job : Job? {
//    get { }
//    set(value) {
//    }
//  }
//  
//  fileprivate var _spouse : Person? = nil
//  open var spouse : Person? {
//    get { }
//    set(value) {
//    }
//  }
//  
//  public init(firstName : String, lastName: String, age : Int) {
//    self.firstName = firstName
//    self.lastName = lastName
//    self.age = age
//  }
//  
//  open func toString() -> String {
//  }
//}
//
//////////////////////////////////////
//// Family
////
//open class Family {
//  fileprivate var members : [Person] = []
//  
//  public init(spouse1: Person, spouse2: Person) {
//  }
//  
//  open func haveChild(_ child: Person) -> Bool {
//  }
//  
//  open func householdIncome() -> Int {
//  }
//}
//
//



