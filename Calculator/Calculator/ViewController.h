//
//  ViewController.h
//  Calculator
//
//  Created by 周乐 on 16/2/5.
//  Copyright © 2016年 ericlezhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *numTextView;
@property (weak, nonatomic) IBOutlet UITextView *signTextView;
- (IBAction)clear:(id)sender;
- (IBAction)negative:(id)sender;
- (IBAction)operate:(id)sender;
- (IBAction)equal:(id)sender;

- (IBAction)num:(id)sender;

@end

