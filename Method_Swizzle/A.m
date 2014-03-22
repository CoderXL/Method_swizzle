//
//  A.m
//  Method_Swizzle
//
//  Created by Liu Yue on 3/21/14.
//  Copyright (c) 2014 devliu.com. All rights reserved.
//

#import "A.h"

@implementation A

- (id)init
{
    self = [super init];
    if (self) {
        [[self self] self];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"I am dealloced, YEAH");
}

@end
