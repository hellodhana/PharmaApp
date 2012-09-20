//
//  SFAUtils.h
//  SFA
//
//  Created by Martin Heras on 4/5/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFAUtils : NSObject {
    
}

// Converts a float to a String in money format ($ xx.xx).
+ (NSString *)moneyFormattedStringFromFloatValue:(float)money;


+ (NSString *)moneyFormattedStringFromNumberValue:(NSNumber *)money;

// Adds a custom gradient to the background of the given view.
+ (void)addCustomGradientToView:(UIView *)view fromColor:(UIColor *)color1 toColor:(UIColor *)color2;

// Adds a central gradient to the background of the given view.
+ (void)addCentralGradientToView:(UIView *)view fromColor:(UIColor *)color1 toColor:(UIColor *)color2;

// Adds a multi gradient to the background of the given view.
+ (void)addMultiGradientToView:(UIView *)view beginColor:(UIColor *)color1 middleColor:(UIColor *)color2 finalColor:(UIColor *)color3;

// Removes the central gradient to the background of the given view.
+ (void)removeCentralGradientFromView:(UIView *)view;

// Returns ths application font with the desired size
+ (UIFont *)applicationFontWithSize:(float)size;

// Adds a multi gradient to the background of the given view.
+ (void)addMultiGradientToView:(UIView *)view beginColor:(UIColor *)color1 middleColor:(UIColor *)color2 finalColor:(UIColor *)color3;

+(BOOL)directoryExistsAtAbsolutePath:(NSString*)filename;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length; 

+ (NSString *) getCurrentMonth;

+ (NSArray *) getYTDMonths;
@end
