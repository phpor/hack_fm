//
//  HTWViewController.m
//  ConnectTheWorld
//
//  Created by weichao on 14-1-11.
//  Copyright (c) 2014年 weichao. All rights reserved.
//

#import "HTWViewController.h"
#import "CHTRemoteCalls.h"
#import <QuartzCore/QuartzCore.h>
#import "KxMenu.h"


#define TextViewTag 101

@interface HTWViewController ()

@end

@implementation HTWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITextView *myTextView = (UITextView *)[self.view viewWithTag:TextViewTag];
    myTextView.text = @"";
    myTextView.layer.borderColor = [UIColor grayColor].CGColor;
    myTextView.layer.borderWidth =1.0;
    myTextView.layer.cornerRadius =5.0;
    
    NSArray *CodeArray = [CategoryButtonList componentsSeparatedByString:@","];
    for (NSString *code in CodeArray) {
        NSInteger i = [CodeArray indexOfObject:code];
        float originX = 10+i*70;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(originX, 500, 60, 30);
        button.backgroundColor = [UIColor blackColor];
        [button setTitle:code forState:UIControlStateNormal];
        if ([code isEqualToString:@"listen"]) {
            [button addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if([code isEqualToString:@"clear"]) {
            [button addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
        }
            
        

        [self.view addSubview:button];
    }

}

-(void)clear:(UIButton *)sender
{
    UITextView *myTextView = (UITextView *)[self.view viewWithTag:TextViewTag];
    myTextView.text = @"";
    
}
- (void)showMenu:(UIButton *)sender
{
    
    UIButton *button = (UIButton *)sender;
    NSString *title = button.titleLabel.text;
    NSArray *titleArray;
    
    if ([title isEqualToString:@"listen"]) {
        titleArray = [FMPlayCodeList componentsSeparatedByString:@","];
        NSArray *menuItems =
        @[
          
          [KxMenuItem menuItem:titleArray[0]
                         image:nil
                        target:nil
                        action:@selector(buttonClick:)],
          
          [KxMenuItem menuItem:titleArray[1]
                         image:nil
                        target:self
                        action:@selector(buttonClick:)],
          
          [KxMenuItem menuItem:titleArray[2]
                         image:nil
                        target:self
                        action:@selector(buttonClick:)],
          
          [KxMenuItem menuItem:titleArray[3]
                         image:nil
                        target:self
                        action:@selector(buttonClick:)],
          ];
        
        KxMenuItem *first = menuItems[0];
        first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
        first.alignment = NSTextAlignmentCenter;
        
        [KxMenu showMenuInView:self.view
                      fromRect:sender.frame
                     menuItems:menuItems];
    }
    else
    {
        titleArray = [FMOrderAddress componentsSeparatedByString:@","];
        NSArray *menuItems =
        @[
          
          [KxMenuItem menuItem:titleArray[0]
                         image:nil
                        target:nil
                        action:@selector(buttonClick:)],
          
          [KxMenuItem menuItem:titleArray[1]
                         image:nil
                        target:self
                        action:@selector(buttonClick:)]
          ];
        
        KxMenuItem *first = menuItems[0];
        first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
        first.alignment = NSTextAlignmentCenter;
        
        [KxMenu showMenuInView:self.view
                      fromRect:sender.frame
                     menuItems:menuItems];
    }
    
}

-(void)buttonClick:(id)sender
{
    KxMenuItem *item = (KxMenuItem  *)sender;
    NSString *title = item.title;
    if ([title isEqualToString:@"clearlog"]) {
        UITextView *myTextView = (UITextView *)[self.view viewWithTag:TextViewTag];
        myTextView.text = @"";
    }
    else
    {
        [CHTRemoteCalls sendMessage:title withBlock:^(NSString *returnJson) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                            UITextView *myTextView = (UITextView *)[self.view viewWithTag:TextViewTag];
                myTextView.text = [NSString stringWithFormat:@"%@\n====================================\n%@",myTextView.text,returnJson];
    
            });


            
        }];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
