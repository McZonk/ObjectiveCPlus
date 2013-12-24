//
//  NSObject+OCPSwizzle.h
//  Plus-iOS
//
//  Created by Maximilian Christ on 2013-02-06.
//  Copyright (c) 2013 mczonk.de. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OCPSwizzle)

+ (BOOL)exchangeSelector:(SEL)oldSelector withSelector:(SEL)newSelector;
+ (BOOL)exchangeClassSelector:(SEL)oldSelector withSelector:(SEL)newSelector;

+ (BOOL)addSelector:(SEL)newSelector originalSelector:(SEL)originalSelector;
+ (BOOL)addClassSelector:(SEL)newSelector originalSelector:(SEL)originalSelector;

@end
