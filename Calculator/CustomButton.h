//
//  CustomButton.h
//  Calculator
//
//  Created by Pritesh Nandgaonkar on 12/05/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomButton : UIButton

@property(assign, nonatomic) IBInspectable CGFloat borderWidth;
@property(strong, nonatomic) IBInspectable UIColor *borderColor;
@property(strong, nonatomic) IBInspectable NSString *value;

@end
