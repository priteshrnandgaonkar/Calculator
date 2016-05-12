//
//  CustomButton.m
//  Calculator
//
//  Created by Pritesh Nandgaonkar on 12/05/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

//- (void)awakeFromNib {
//    self.layer.borderColor = self.borderColor.CGColor;
//    self.layer.borderWidth = self.borderWidth;
//}
//
//- (void)prepareForInterfaceBuilder {
//    self.layer.borderColor = self.borderColor.CGColor;
//    self.layer.borderWidth = self.borderWidth;
//
//}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myFrame = self.bounds;
    CGContextSetLineWidth(context, _borderWidth);
    [_borderColor set];
    UIRectFrame(myFrame);
}

@end
