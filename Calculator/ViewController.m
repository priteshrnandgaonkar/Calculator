//
//  ViewController.m
//  Calculator
//
//  Created by Pritesh Nandgaonkar on 12/05/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "ViewController.h"
#import "CustomButton.h"
#import "NSString+ReversePolish.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@property (strong, nonatomic) NSString *displayString;
@property (assign, nonatomic) BOOL isEqualToTapped;

@end

static NSString * const kDefaultDisplay = @"0";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayString = kDefaultDisplay;
    self.isEqualToTapped = NO;
    // Do any additional setup after loading the view, typically from a nib.
   }

- (void)setDisplayString:(NSString *)displayString {
    _displayString = displayString;
    self.displayLabel.text = _displayString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addEntity:(CustomButton *)sender {
    
    NSString *updatedString = sender.value;
    
    if(![self.displayString isEqualToString:kDefaultDisplay] && !self.isEqualToTapped) {
        NSMutableString *mutDisplayString = self.displayString.mutableCopy;
        updatedString = [mutDisplayString stringByAppendingString:sender.value];
    }
    self.isEqualToTapped = NO;
    self.displayString = updatedString;
}

- (IBAction)deleteLastCharacter:(CustomButton *)sender {
    if(self.displayString.length > 1) {
        self.displayString = [self.displayString substringToIndex:self.displayString.length-1];
    }
    else {
        self.displayString = kDefaultDisplay;
    }
}
- (IBAction)deleteAllCharacters:(CustomButton *)sender {
    self.displayString = kDefaultDisplay;
}
- (IBAction)EqualToTapped:(id)sender {
    
//    NSString *test=@"26-6-5+8.4/2+9.3^2";
//    CGFloat result = [NSString evaluateExpressionWithOperatorPrecedenceArray:@[@"^", @"*/%", @"+-"] availableOperators:@"^*/%+-" evalExpression:test];
//    NSLog(@"temp=%f", result);
    self.isEqualToTapped = YES;
    self.displayString = [NSString stringWithFormat:@"%0.6f", [NSString evaluateExpressionWithOperatorPrecedenceArray:@[@"^", @"*/%", @"+-"] availableOperators:@"^*/%+-" evalExpression:self.displayString]];


}

@end
