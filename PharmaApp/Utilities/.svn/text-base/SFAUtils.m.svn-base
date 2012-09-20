//
//  SFAUtils.m
//  SFA
//
//  Created by Martin Heras on 4/5/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAUtils.h"

@implementation SFAUtils

+ (NSString *)moneyFormattedStringFromFloatValue:(float)money 
{
    NSLocale *enUSLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setLocale:enUSLocale];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *fmtStr = [nf stringFromNumber:[NSNumber numberWithFloat:money]];
    return fmtStr;
}

+ (NSString *)moneyFormattedStringFromNumberValue:(NSNumber *)money 
{
    NSLocale *enUSLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setLocale:enUSLocale];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *fmtStr = [nf stringFromNumber:money];
    
    return fmtStr;
}

+ (void)addCustomGradientToView:(UIView *)view fromColor:(UIColor *)color1 toColor:(UIColor *)color2
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = view.bounds;
	gradient.colors = [NSArray arrayWithObjects:(id)[color1 CGColor], (id)[color2 CGColor], nil];
	view.layer.masksToBounds = YES;
	[view.layer insertSublayer:gradient atIndex:0];
}

+ (void)addCentralGradientToView:(UIView *)view fromColor:(UIColor *)color1 toColor:(UIColor *)color2
{
    CAGradientLayer *topGradient = [CAGradientLayer layer];
	topGradient.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height / 2);
	topGradient.colors = [NSArray arrayWithObjects:(id)[color1 CGColor], (id)[color2 CGColor], nil];
	view.layer.masksToBounds = YES;
    
    CAGradientLayer *bottomGradient = [CAGradientLayer layer];
	bottomGradient.frame = CGRectMake(0, view.frame.size.height / 2, view.frame.size.width, view.frame.size.height / 2);
	bottomGradient.colors = [NSArray arrayWithObjects:(id)[color2 CGColor], (id)[color1 CGColor], nil];
	view.layer.masksToBounds = YES;

	[view.layer insertSublayer:topGradient atIndex:0];
    [view.layer insertSublayer:bottomGradient atIndex:1];
}

+ (void)addMultiGradientToView:(UIView *)view beginColor:(UIColor *)color1 middleColor:(UIColor *)color2 finalColor:(UIColor *)color3
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = view.bounds;
	gradient.colors = [NSArray arrayWithObjects:(id)[color1 CGColor], (id)[color2 CGColor], (id)[color3 CGColor], nil];
	view.layer.masksToBounds = YES;
	[view.layer insertSublayer:gradient atIndex:0];
}


+ (void)removeCentralGradientFromView:(UIView *)view
{
    // The views with centered gradient layers had 2 layers at the beggining
    NSArray *subLayers = view.layer.sublayers;
    if (subLayers.count > 2) {
        CALayer *layer0 = [view.layer.sublayers objectAtIndex:0];
        CALayer *layer1 = [view.layer.sublayers objectAtIndex:1];
        [layer0 removeFromSuperlayer];
        [layer1 removeFromSuperlayer];
    }
}

+ (UIFont *)applicationFontWithSize:(float)size
{
    return [UIFont fontWithName:@"Futura" size:size];
}

+(BOOL)directoryExistsAtAbsolutePath:(NSString*)filename 
{
    BOOL isDirectory;
    BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:filename isDirectory:&isDirectory];
    
    return fileExistsAtPath && isDirectory;
}

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];          
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];                      
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];                      
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (NSString *) getCurrentMonth
{
    return @"May";
}

+ (NSArray *) getYTDMonths
{
    return [[NSArray alloc] initWithObjects:@"January",@"February", @"March", @"April", @"May", nil];
}

@end
