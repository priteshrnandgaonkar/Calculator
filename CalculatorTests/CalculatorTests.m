//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Pritesh Nandgaonkar on 12/05/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Calculation.h"

@interface CalculatorTests : XCTestCase

@end

@implementation CalculatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddition {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *addedString = [NSString evaluateExpressionWithOperatorPrecedenceArray:@[@"^", @"*/%", @"+-"] availableOperators:@"^*/%+-" evalExpression:@"3+6"];
    XCTAssert([addedString isEqualToString:@"9"]);
}

- (void)testSubtraction {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *subtractedString = [NSString evaluateExpressionWithOperatorPrecedenceArray:@[@"^", @"*/%", @"+-"] availableOperators:@"^*/%+-" evalExpression:@"3-6"];
    XCTAssert([subtractedString isEqualToString:@"-3"]);
}

- (void)testMultiplication {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *multipliedString = [NSString evaluateExpressionWithOperatorPrecedenceArray:@[@"^", @"*/%", @"+-"] availableOperators:@"^*/%+-" evalExpression:@"3*6"];
    XCTAssert([multipliedString isEqualToString:@"18"]);
}

- (void)testDivision {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *divisionString = [NSString evaluateExpressionWithOperatorPrecedenceArray:@[@"^", @"*/%", @"+-"] availableOperators:@"^*/%+-" evalExpression:@"6/3"];
    XCTAssert([divisionString isEqualToString:@"2"]);
}

- (void)testModulo {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *moduloString = [NSString evaluateExpressionWithOperatorPrecedenceArray:@[@"^", @"*/%", @"+-"] availableOperators:@"^*/%+-" evalExpression:@"5%3"];
    XCTAssert([moduloString isEqualToString:@"2"]);
}

- (void)testPower {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *powerString = [NSString evaluateExpressionWithOperatorPrecedenceArray:@[@"^", @"*/%", @"+-"] availableOperators:@"^*/%+-" evalExpression:@"2^3"];
    XCTAssert([powerString isEqualToString:@"8"]);
}

- (void)testExpression {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *expressionString = [NSString evaluateExpressionWithOperatorPrecedenceArray:@[@"^", @"*/%", @"+-"] availableOperators:@"^*/%+-" evalExpression:@"730-2^6-1024/2^2^2+2*10%3"];
    XCTAssert([expressionString isEqualToString:@"604"]);
}


@end
