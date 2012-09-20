//
//  MSUtils.m
//  FSE
//
//  Created by Pablo Calcagnino on 4/19/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "MSUtils.h"

@implementation MSUtils

+ (NSString *)moneyFormattedStringFromFloatValue:(float)money 
{
    NSLocale *enUSLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setLocale:enUSLocale];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *fmtStr = [nf stringFromNumber:[NSNumber numberWithFloat:money]];

    
    return fmtStr;
}

+ (UIFont *)applicationFontWithSize:(float)size
{
    return [UIFont fontWithName:@"Futura" size:size];
}


+(UIView*)viewFromBundle:(NSBundle*)bundle nibNamed:(NSString*)nibName type:(Class)type owner:(id)owner {
	
	NSArray* objects = [bundle loadNibNamed:nibName owner:owner options:nil];
	
	for (int i=0; i < [objects count]; i++) {
		if ([[objects objectAtIndex:i] isKindOfClass:type]) {
			return [objects objectAtIndex:i];
		}
	}
	
	return nil;
}

#pragma mark -
#pragma mark Gradient

+ (void)addCustomGradientToView:(UIView *)view fromColor:(UIColor *)color1 toColor:(UIColor *)color2
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = view.bounds;
	gradient.colors = [NSArray arrayWithObjects:(id)[color1 CGColor], (id)[color2 CGColor], nil];
	view.layer.masksToBounds = YES;
	[view.layer insertSublayer:gradient atIndex:0];
}

+ (void)addMultiGradientToView:(UIView *)view beginColor:(UIColor *)color1 middleColor:(UIColor *)color2 finalColor:(UIColor *)color3
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = view.bounds;
	gradient.colors = [NSArray arrayWithObjects:(id)[color1 CGColor], (id)[color2 CGColor], (id)[color3 CGColor], nil];
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

@end
