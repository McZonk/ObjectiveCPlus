//
//  NSObject+OCPSwizzle.m
//  Plus-iOS
//
//  Created by Maximilian Christ on 2013-02-06.
//  Copyright (c) 2013 mczonk.de. All rights reserved.
//

#import "NSObject+OCPSwizzle.h"

#import <objc/runtime.h>

static BOOL method_swizzle(Class cls, SEL oldSelector, SEL newSelector) {
    Method oldMethod = class_getInstanceMethod(cls, oldSelector);
    Method newMethod = class_getInstanceMethod(cls, newSelector);
	
	if(oldMethod != 0 && newMethod != 0) {
        IMP oldImp = method_getImplementation(oldMethod);
        IMP newImp = method_getImplementation(newMethod);
		
		method_setImplementation(oldMethod, newImp);
		method_setImplementation(newMethod, oldImp);
		
		return YES;
	}
	
	return NO;
}

static BOOL method_add(Class cls, SEL newSelector, SEL originalSelector) {
	IMP originalImplementation = class_getMethodImplementation(cls, originalSelector);
	if(!originalImplementation) {
		return NO;
	}
	
	Method originalMethod = class_getInstanceMethod(cls, originalSelector);
	if(!originalMethod) {
		return NO;
	}
	
	const char* originalTypes = method_getTypeEncoding(originalMethod);
	
	return class_addMethod(cls, newSelector, originalImplementation, originalTypes);
}


@implementation NSObject (OCPSwizzle)

+ (BOOL)exchangeSelector:(SEL)oldSelector withSelector:(SEL)newSelector {
	return method_swizzle(self, oldSelector, newSelector);
}

+ (BOOL)exchangeClassSelector:(SEL)oldSelector withSelector:(SEL)newSelector {
	Class metaClass = objc_getMetaClass(class_getName(self));
	return method_swizzle(metaClass, oldSelector, newSelector);
}

+ (BOOL)addSelector:(SEL)newSelector originalSelector:(SEL)originalSelector {
	return method_add(self, newSelector, originalSelector);
}

+ (BOOL)addClassSelector:(SEL)newSelector originalSelector:(SEL)originalSelector {
	Class metaClass = objc_getMetaClass(class_getName(self));
	return method_add(metaClass, newSelector, originalSelector);
}

@end
