//
//  NSString+Calculation.h
//  Calculator
//
//  Created by Pritesh Nandgaonkar on 12/05/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Calculation)

+ (NSString *)evaluateExpressionWithOperatorPrecedenceArray:(NSArray<NSString *> *)operatorArray availableOperators:(NSString *)operator evalExpression:(NSString *)evalExpr;
+ (CGFloat)evaluateleftOperand:(CGFloat)left rightOperand:(CGFloat)right operator:(NSString *)operation;
@end
