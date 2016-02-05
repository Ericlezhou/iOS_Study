//
//  ViewController.m
//  Calculator
//
//  Created by 周乐 on 16/2/5.
//  Copyright © 2016年 ericlezhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSDecimalNumber *leftValue;
@property (nonatomic, strong) NSDecimalNumber *rightValue;
@property (nonatomic, assign) BOOL clearNum;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftValue = [NSDecimalNumber zero];
    self.rightValue = [NSDecimalNumber zero];
    self.clearNum = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//clear the input
-(void)clear:(id)sender{
    self.numTextView.text = @"0";
    self.signTextView.text = @"";
    self.leftValue = [NSDecimalNumber zero];
    self.rightValue = [NSDecimalNumber zero];
}

//change the sign of the input num
-(void)negative:(id)sender{
    NSString *str =  self.numTextView.text;
    if (str.length > 0) {
        if ([str characterAtIndex:0] == '-') {
            self.numTextView.text = [str substringFromIndex:1];
        }else{
            self.numTextView.text = [@"-" stringByAppendingString:str];
        }
    }
}

//equal operation
-(void)equal:(id)sender{
    NSString *signString = self.signTextView.text;
    if (signString.length > 0) {
        self.rightValue = [NSDecimalNumber decimalNumberWithString:self.numTextView.text];
        if ([signString isEqualToString:@"+"]) {
            self.leftValue = [self.leftValue performSelector:@selector(decimalNumberByAdding:) withObject:self.rightValue];
            
        }else if ([signString isEqualToString:@"-"]){
            self.leftValue = [self.leftValue performSelector:@selector(decimalNumberBySubtracting:) withObject:self.rightValue];
            
        }else if ([signString isEqualToString:@"*"]){
            self.leftValue = [self.leftValue performSelector:@selector(decimalNumberByMultiplyingBy:) withObject:self.rightValue];
            
        }else if ([signString isEqualToString:@"/"]){
            if ([self.rightValue isEqualToNumber:[NSDecimalNumber zero]])
            {
                UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"Warnning" message:@"The divide operand can not be zero." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
                [alertCtrl addAction:cancelAction];
                [self presentViewController:alertCtrl animated:YES completion:nil];
                return;
            }else{
                self.leftValue = [self.leftValue performSelector:@selector(decimalNumberByDividingBy:) withObject:self.rightValue];
            }
        }
        self.numTextView.text = [self.leftValue stringValue];
    }
    self.clearNum = YES;
    self.signTextView.text = @"";
}


//operatation implementation

- (void)operate:(id)sender{
    self.leftValue = [NSDecimalNumber decimalNumberWithString:self.numTextView.text];
    self.signTextView.text = ((UIButton *)sender).titleLabel.text;
    self.clearNum = YES;
}

//num
- (void)num:(id)sender{
    
    if (self.clearNum) {
        self.numTextView.text = @"";
        self.clearNum = NO;
    }
    UIButton *clickedBtn = (UIButton *)sender;
    if ([clickedBtn.titleLabel.text isEqualToString:@"0"])
    {
        if ([self.numTextView.text isEqualToString:@"0"]) {
        }else{
            self.numTextView.text = [self.numTextView.text stringByAppendingString:clickedBtn.titleLabel.text];
        }
    }
    else if([clickedBtn.titleLabel.text isEqualToString:@"."])
    {
        NSString *str = self.numTextView.text;
        BOOL hasSpot = false;
        for (int i = 0; i < str.length; i++)
        {
            if ([str characterAtIndex:i] == '.')
            {
                hasSpot = true;
                break;
            }
        }
        if (!hasSpot)
        {
            self.numTextView.text = [str stringByAppendingString:@"."];
        }
    }
    else
    {
        if ([self.numTextView.text isEqualToString:@"0"]) {
            self.numTextView.text = @"";
        }
        self.numTextView.text = [self.numTextView.text stringByAppendingString:clickedBtn.titleLabel.text];
    }
    
    
}

@end
