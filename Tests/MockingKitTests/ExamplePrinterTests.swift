//
//  ExamplePrinterTests.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2020-07-17.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import MockingKit

class ExamplePrinterTests: QuickSpec {

    override func spec() {
        
        describe("Example printer") {
            
            it("works") {
                let printer = MockPrinter()
                printer.print("Hello!")
                let inv = printer.invokations(of: printer.printRef)
                expect(inv.count).to(equal(1))
                expect(inv[0].arguments).to(equal("Hello!"))
                expect(printer.hasInvoked(printer.printRef)).to(beTrue())
                expect(printer.hasInvoked(printer.printRef, numberOfTimes: 1)).to(beTrue())
                expect(printer.hasInvoked(printer.printRef, numberOfTimes: 2)).to(beFalse())
            }
        }
    }
}

private protocol Printer {
    func print(_ text: String)
}

private class MockPrinter: Mock, Printer {

    lazy var printRef = MockReference(print)

    func print(_ text: String) {
        invoke(printRef, args: (text))
    }
}
