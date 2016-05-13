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
    
    NSUInteger length = str.length;
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [str rangeOfString: mutOperatorArray.firstObject options:0 range:range];
        if(range.location != NSNotFound)
        {
            break;
        }
    }
    if([mutOperatorArray.firstObject isEqualToString:@"-"] && range.location == 0) {
        
        return mutOperatorArray.count > 1? mutOperatorArray[1] : mutOperatorArray.firstObject;
    }
    return mutOperatorArray.firstObject;
}

+ (NSString *)evaluateExpressionWithOperatorPrecedenceArray:(NSArray<NSString *> *)operatorArray availableOperators:(NSString *)operator evalExpression:(NSString *)evalExpr{
    __block NSString *evaluationString = evalExpr;
    [operatorArray enumerateObjectsUsingBlock:^(NSString * _Nonnull operators, NSUInteger idx, BOOL * _Nonnull stop) {

        NSString *operatorString = [NSString getFirstOperatorFromString:evaluationString operator:operators];
        BOOL loopCondition = YES;
        //peratorString.length > 0
        while(loopCondition) {
           // evaluationString
            NSLog(@"before trim operator string, %@", operatorString);
            NSString *newEvaluationString = [NSString trimExpression:evaluationString forOperatorString:operatorString withAllOperators:operator];
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:operator];
            NSArray<NSString *> *operatorArray = [newEvaluationString componentsSeparatedByCharactersInSet:set.invertedSet];
            NSMutableArray<NSString *> *mutOperatorArray = operatorArray.mutableCopy;
            [mutOperatorArray removeObject:@""];
            
            if([newEvaluationString isEqualToString:evaluationString] && mutOperatorArray.count > 1 && [operatorString isEqualToString:@"-"]) {
                NSCharacterSet *set2 = [NSCharacterSet characterSetWithCharactersInString:@"+/^*%"];
                
                NSArray<NSString *> *operatorArray2 = [evaluationString componentsSeparatedByCharactersInSet:set2.invertedSet];
                NSMutableArray<NSString *> *mutOperatorArray2 = operatorArray2.mutableCopy;
                [mutOperatorArray2 removeObject:@""];
                if(mutOperatorArray2.count >= 1) {
                    NSUInteger length = evaluationString.length;
                    NSRange range = NSMakeRange(0, length);
                    while(range.location != NSNotFound)
                    {
                        range = [evaluationString rangeOfString: mutOperatorArray2.firstObject options:0 range:range];
                        if(range.location != NSNotFound)
                        {
                            range = NSMakeRange(range.location, length - range.location);
                            break;
                        }
                    }
                    NSMutableString *mutStr = evaluationString.mutableCopy;
                    [mutStr deleteCharactersInRange:range];
                    newEvaluationString = [NSString stringWithString:mutStr];
                    newEvaluationString = [NSString trimNegativeExpressionString:newEvaluationString];
                    NSString *str = [evaluationString substringWithRange:range];
                    newEvaluationString = [NSString stringWithFormat:@"%@%@", newEvaluationString, str];

                }
                else {
                    newEvaluationString = [NSString trimNegativeExpressionString:newEvaluationString];

                }
                NSLog(@"newEvaluationString ,%@", newEvaluationString);
            }
            
            if([newEvaluationString isEqualToString:evaluationString] || [newEvaluationString containsString:@"NAN"]) {
                newEvaluationString = [newEvaluationString containsString:@"NAN"]? @"NAN" : newEvaluationString;
                loopCondition = NO;
            }
            evaluationString = newEvaluationString;
            operatorString = [NSString getFirstOperatorFromString:evaluationString operator:operators];
            NSLog(@"after trim operator string, %@", operatorString);

        }
        
    }];
    return evaluationString;
}

+ (NSString *)trimExpression:(NSString *)evaluationString forOperatorString:(NSString *)operatorString withAllOperators:(NSString *)operator {
    
    NSArray<NSString *> *characters=[evaluationString componentsSeparatedByString:operatorString];
    
    if([operatorString isEqualToString:@"-"] && characters.count == 2 && characters[0].length == 0) {
        return evaluationString;
    }
    
    if(characters.count <= 1) {
        return characters[0];
    }
    
    NSString *leftString = ((NSString*)([characters[0] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:operator]].lastObject));
    if(characters[0].length >= 1 && [characters[0] characterAtIndex:0] == '-' && characters[0].length == 1 + leftString.length) {
        leftString = characters[0];
    }

    CGFloat leftOperand = leftString.floatValue;
    
    NSString *rightString = ((NSString*)([characters[1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:operator]].firstObject));
    CGFloat rightOperand = rightString.floatValue;
   
    CGFloat interimResult = [NSString evaluateleftOperand:leftOperand rightOperand:rightOperand operator:operatorString];

    NSString *evaluatedExpression = [NSString stringWithFormat:@"%@%@%@", leftString, operatorString, rightString];
    
    NSString *interimResultString = @(interimResult).stringValue;
    if([operatorString isEqualToString:@"/"] && rightOperand == 0) {
        interimResultString = @"NAN";
    }

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
    NSString *newEvaluationString = [mutUpdatedEvalExpression stringByReplacingCharactersInRange:range withString:interimResultString];
    NSLog(@"Evaluation String, %@", newEvaluationString);

    //[NSString trimExpression:newEvaluationString forOperatorString:operatorString withAllOperators:operator];
    return newEvaluationString;
}

+ (NSString *)trimNegativeExpressionString:(NSString *)str {
    
    NSArray<NSString *> *characters=[str componentsSeparatedByString:@"-"];
    
    if(characters.count == 2 && characters[0].length == 0) {
        return str;
    }
    
    NSUInteger length = str.length;
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [str rangeOfString: [NSString stringWithFormat:@"-%@", characters[1]] options:0 range:range];
        if(range.location != NSNotFound)
        {
            break;
        }
    }

    NSMutableString *mutStr = str.mutableCopy;
    [mutStr deleteCharactersInRange:range];
    NSString *newStr = [NSString stringWithString:mutStr];
    CGFloat result = -1 * characters[1].floatValue + [NSString trimNegativeExpressionString:newStr].floatValue;

    return @(result).stringValue;
}

@end
