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

open class Job {
    fileprivate var title : String
    fileprivate var type : JobType

    public enum JobType {
    case Hourly(Double)
    case Salary(Int)
    }


    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }

    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type{
            case.Hourly(let salary):
                return hours * Int(salary)
            case.Salary(let salary):
                return Int(salary)
        }
    }

    open func raise(_ amt : Double) {
        switch self.type{
            case .Hourly(let salary):
                self.type = JobType.Hourly(salary + amt)
            case .Salary(let salary):
                self.type = JobType.Salary(salary+Int(amt))
        }
    }
}

////////////////////////////////////
// Person

open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0

    fileprivate var _job : Job? = nil
    open var job : Job? {
        get { return _job }
        set(value) {
            if self.age >= 16 {
                self._job = value
            }
        }
    }

    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return _spouse }
        set(value) {
            if self.age >= 18 {
                self._spouse = value
            }
        }
    }

    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }

    open func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:45 job:\(String(describing: self.job)) spouse:\(String(describing: self.spouse ?? nil))]"
    }
}

////////////////////////////////////
// Family

open class Family {
    fileprivate var members : [Person] = []

    public init(spouse1: Person, spouse2: Person) {
        if (spouse1.spouse != nil || spouse2.spouse != nil) {
            print("One of you guys has a spouse already")
        } else{
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            self.members = [spouse1, spouse2]
        }
    }

    open func haveChild(_ child: Person) -> Bool {
        if self.members[0].age > 21 && self.members[1].age > 21 {
            self.members.append(child)
            return true
        }
        return false
    }

    open func householdIncome() -> Int {
        var sum = 0
        for person in self.members{
            switch person._job?.type{
            case.Hourly(let salary)?:
                sum += Int(salary * 2000)
            case.Salary(let salary)?:
                sum += Int(salary)
            case nil: sum += 0
            }
        }
        return sum
    }
}





