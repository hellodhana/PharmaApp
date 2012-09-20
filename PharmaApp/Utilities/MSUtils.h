//
//  MSUtils.h
//  FSE
//
//  Created by Pablo Calcagnino on 4/19/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSUtils : NSObject {
    
}

// Converts a float to a String in money format ($ xx.xx).
+ (NSString *)moneyFormattedStringFromFloatValue:(float)money;

// Adds a custom gradient to the background of the given view.
+ (void)addCustomGradientToView:(UIView *)view fromColor:(UIColor *)color1 toColor:(UIColor *)color2;

// Returns ths application font with the desired size
+ (UIFont *)applicationFontWithSize:(float)size;

+(UIView*)viewFromBundle:(NSBundle*)bundle nibNamed:(NSString*)nibName type:(Class)type owner:(id)owner;

// Adds a custom gradient to the background of the given view.
+ (void)addCustomGradientToView:(UIView *)view fromColor:(UIColor *)color1 toColor:(UIColor *)color2;

// Adds a multi gradient to the background of the given view.
+ (void)addMultiGradientToView:(UIView *)view beginColor:(UIColor *)color1 middleColor:(UIColor *)color2 finalColor:(UIColor *)color3;

// Adds a central gradient to the background of the given view.
+ (void)addCentralGradientToView:(UIView *)view fromColor:(UIColor *)color1 toColor:(UIColor *)color2;

// Removes the central gradient to the background of the given view.
+ (void)removeCentralGradientFromView:(UIView *)view;

@end
