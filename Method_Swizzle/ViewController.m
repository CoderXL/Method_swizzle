//
//  ViewController.m
//  Method_Swizzle
//
//  Created by Liu Yue on 3/21/14.
//  Copyright (c) 2014 devliu.com. All rights reserved.
//

#import "ViewController.h"
#import "A.h"
#import <objc/runtime.h>

@interface ViewController ()
- (IBAction)swizzle_method:(UIButton *)sender;
- (IBAction)showA:(UIButton *)sender;
- (IBAction)showB:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

+ (void)initialize
{
    NSString *className = NSStringFromClass(self.class);
    NSLog(@"classname in class method %@", className);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swizzle_method:(UIButton *)sender {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = self.class;
        Method showAMethod = class_getInstanceMethod(class, @selector(showA:));
        Method showBMethod = class_getInstanceMethod(class, @selector(showB:));

        //添加实现，但不会覆盖之前的实现
        BOOL didAddMethod = class_addMethod(class, @selector(showA:), method_getImplementation(showBMethod), method_getTypeEncoding(showBMethod));
        if (didAddMethod) {
            class_replaceMethod(class, @selector(showB:), method_getImplementation(showAMethod), method_getTypeEncoding(showAMethod));
        } else {
            method_exchangeImplementations(showAMethod, showBMethod);
        }
    });
}

- (IBAction)showA:(UIButton *)sender {
    NSLog(@"A is showing");
}

- (IBAction)showB:(UIButton *)sender {
    NSLog(@"B is showing");
}
@end
