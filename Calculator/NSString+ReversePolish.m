//
//  NSString+ReversePolish.m
//  Calculator
//
//  Created by Pritesh Nandgaonkar on 12/05/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "NSString+ReversePolish.h"
#import <math.h>
@implementation NSString (ReversePolish)
+ (CGFloat)evaluateleftOperand:(CGFloat)left rightOperand:(CGFloat)right operator:(NSString *)operation {
    CGFloat result = 0;
    if([operation isEqualToString:@"+"]) {
        result = left + right;
    }
    else if([operation isEqualToString:@"-"]) {
        result = left - right;
    }
    else if([operation isEqualToString:@"*"]) {
        result = left * right;
    }
    else if([operation isEqualToString:@"/"]) {
        result = left / right;
    }
    else if([operation isEqualToString:@"%"]) {
        result = fmodf(left, right);
    }
    else if([operation isEqualToString:@"^"]) {
        result = pow(left, right);
    }
    return result;
}

+ (NSString *)getFirstOperatorFromString:(NSString *)str operator:(NSString *)operator {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:operator];
    
    NSArray<NSString *> *operatorArray = [str componentsSeparatedByCharactersInSet:set.invertedSet];
    NSMutableArray<NSString *> *mutOperatorArray = operatorArray.mutableCopy;
    [mutOperatorArray removeObject:@""];
    if(mutOperatorArray.count <= 0){
        return @"";
    }
    return mutOperatorArray.firstObject;
}

+ (CGFloat)evaluateExpressionWithOperatorPrecedenceArray:(NSArray<NSString *> *)operatorArray availableOperators:(NSString *)operator evalExpression:(NSString *)evalExpr{
    __block NSString *evaluationString = evalExpr;
    [operatorArray enumerateObjectsUsingBlock:^(NSString * _Nonnull operators, NSUInteger idx, BOOL * _Nonnull stop) {

        NSString *operatorString = [NSString getFirstOperatorFromString:evaluationString operator:operators];
        while(operatorString.length > 0) {
            evaluationString = [NSString trimExpression:evaluationString forOperatorString:operatorString withAllOperators:operator];
            operatorString = [NSString getFirstOperatorFromString:evaluationString operator:operators];
        }
        
    }];
    return evaluationString.floatValue;
}

+ (NSString *)trimExpression:(NSString *)evaluationString forOperatorString:(NSString *)operatorString withAllOperators:(NSString *)operator {
    
    NSArray<NSString *> *characters=[evaluationString componentsSeparatedByString:operatorString];
    
    if(characters.count <= 1) {
        return characters.firstObject;
    }
 
    NSString *leftString = ((NSString*)([characters[0] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:operator]].lastObject));
    CGFloat leftOperand = leftString.floatValue;
    
    NSString *rightString = ((NSString*)([characters[1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:operator]].firstObject));
    CGFloat rightOperand = rightString.floatValue;
    
    CGFloat interimResult = [NSString evaluateleftOperand:leftOperand rightOperand:rightOperand operator:operatorString];
    
    NSString *evaluatedExpression = [NSString stringWithFormat:@"%@%@%@", leftString, operatorString, rightString];
    
    NSUInteger length = evaluationString.length;
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [evaluationString rangeOfString: evaluatedExpression options:0 range:range];
        if(range.location != NSNotFound)
        {
            break;
        }
    }
    NSMutableString *mutUpdatedEvalExpression = evaluationString.mutableCopy;
    NSString *newEvaluationString = [mutUpdatedEvalExpression stringByReplacingCharactersInRange:range withString:@(interimResult).stringValue];
    return [NSString trimExpression:newEvaluationString forOperatorString:operatorString withAllOperators:operator];
}

@end
