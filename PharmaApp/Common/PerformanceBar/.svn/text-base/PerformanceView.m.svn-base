//
//  PerformanceView.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PerformanceView.h"

#define BAR_HEIGHT 15 
#define BAR_X_OFFSET 2.0
#define BAR_TOTAL_HEIGHT 28
#define BAR_TEXT_Y_OFFSET 3
#define BAR_TEXT_HEIGHT 10
#define BAR_TEXT_WIDTH 80
#define BAR_LINE_LOCATION 0.8
#define BAR_LINE_WIDTH 2.0

#define BAR_STYLE_ONECOLOR 1
#define BAR_STYLE_TWOCOLOR 2
@interface PerformanceView()
{
    int _percentage;
    int _style;
    NSString *_text;
}
- (void)loadViewContentsWithFrame:(CGRect)rect;
- (void)drawStyle1:(CGRect)rect;
- (void)drawStlye2:(CGRect)rect;
- (void)drawStyle3:(CGRect)rect;
- (void)drawStlye4:(CGRect)rect;

@property (nonatomic, assign) int percentage;
@property (nonatomic, assign) int style;
@property (nonatomic, retain) NSString *text;
@end
@implementation PerformanceView
@synthesize percentage=_percentage;
@synthesize style=_style;
@synthesize text=_text;

- (id)initWithFrame:(CGRect)frame andPercentage:(int)per andStyle:(int)style
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.percentage = per;
        self.style = style;
        [self loadViewContentsWithFrame:frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andPercentage:(int)per text:(NSString *)text andStyle:(int)style
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.percentage = per;
        self.style = style;
        self.text = text;
        [self loadViewContentsWithFrame:frame];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.percentage > 0 || self.style > 0) {

        if(self.style == BAR_STYLE_ONECOLOR)
        {
            [self drawStyle3:rect];
        }
        else if(self.style == BAR_STYLE_TWOCOLOR)
        {
            [self drawStlye2:rect];
        }
    }
}

- (void)drawStyle3:(CGRect)rect
{
    UIColor *barColor = [UIColor greenColor];
    
    if(self.percentage <= 85)
    {
        barColor = [UIColor redColor];
    }
    else if(self.percentage > 85 && self.percentage <= 95)
    {
        barColor = [UIColor yellowColor];
    }
    else if(self.percentage > 95)
    {
        
         barColor = [UIColor greenColor];
        
    }
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake((CGFloat)BAR_X_OFFSET,(CGFloat)( rect.size.height - BAR_TOTAL_HEIGHT ) / 2.0 + BAR_TEXT_Y_OFFSET + BAR_TEXT_HEIGHT,self.frame.size.width - 2 * BAR_X_OFFSET,BAR_HEIGHT)];
    progressView.progressTintColor = barColor;
    float progressValue = self.percentage / 100.0;
    if(progressValue > 1.0)
    {
        progressValue = 1.0;
    }
    progressView.progress = progressValue;
    
    [self addSubview:progressView];
    
    NSString *lblString = nil;    
    //Add Text
    if(self.text)
    {
        lblString = self.text;
    }
    else
    {
        lblString = [NSString stringWithFormat:@"%d%%",self.percentage];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2.0 - BAR_TEXT_WIDTH / 2.0, progressView.frame.origin.y - BAR_TEXT_Y_OFFSET - BAR_TEXT_HEIGHT, BAR_TEXT_WIDTH, BAR_TEXT_HEIGHT)];
    label.text = lblString;
    label.font = [SFAUtils applicationFontWithSize:10.0];
    label.textColor = [UIColor blackColor];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor]; 
    [self addSubview:label];    
}    

- (void)drawStyle4:(CGRect)rect
{
    
} 

- (void)drawStyle1:(CGRect)rect
{
    //Draw Line
    //self.backgroundColor = [UIColor clearColor];
    //Decide Bar Color
    UIColor *barColor = [UIColor greenColor];
    
    if(self.percentage < 40)
    {
        barColor = [UIColor redColor];
    }
    else if(self.percentage >= 40 && self.percentage < 60)
    {
        barColor = [UIColor yellowColor];
    }
    
    float linexloc = rect.size.width * BAR_LINE_LOCATION;
    
    //Draw Bar
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, (CGFloat)BAR_LINE_WIDTH);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);    
    
    float barWidth = linexloc * ( self.percentage / 100.0 );
    if(barWidth > rect.size.width )
    {
        barWidth = rect.size.width;
    }
    CGContextMoveToPoint(context, 0, 0);
    CGContextSetFillColorWithColor(context, barColor.CGColor);   
    
    CGRect rectangle = CGRectMake((CGFloat)BAR_X_OFFSET,(CGFloat)( rect.size.height - BAR_TOTAL_HEIGHT ) / 2.0 + BAR_TEXT_Y_OFFSET + BAR_TEXT_HEIGHT,(CGFloat)barWidth,(CGFloat)BAR_HEIGHT);
    CGContextAddRect(context, rectangle);
    CGContextFillRect(context, rectangle);
    CGContextStrokePath(context);
    
    //Draw Line
    context = UIGraphicsGetCurrentContext();
    //    
    CGContextSetLineWidth(context, BAR_LINE_WIDTH);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextMoveToPoint(context, linexloc, 4);
    CGContextAddLineToPoint(context, linexloc, rect.size.height - 4);
    
    CGContextStrokePath(context); 
    
    NSString *lblString = nil;
    //Add Text
    if(self.text)
    {
        lblString = self.text;
    }
    else
    {
        lblString = [NSString stringWithFormat:@"%d%%",self.percentage];
    }

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BAR_X_OFFSET + (barWidth / 2) -(BAR_TEXT_WIDTH / 2), rectangle.origin.y - BAR_TEXT_Y_OFFSET - BAR_TEXT_HEIGHT, BAR_TEXT_WIDTH, BAR_TEXT_HEIGHT)];
    label.text = lblString;
    label.font = [SFAUtils applicationFontWithSize:10.0];
    label.textColor = [UIColor blackColor];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor]; 
    [self addSubview:label];    
}

- (void)drawStlye2:(CGRect)rect
{
    float greenWidth = ( rect.size.width - BAR_X_OFFSET) * ( self.percentage / 100.0 );
    float redWidth = ( rect.size.width - BAR_X_OFFSET) - greenWidth;
    
    //Draw Green Bar
    if(greenWidth > 0)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, (CGFloat)BAR_LINE_WIDTH);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);    
        
        if(greenWidth > rect.size.width )
        {
            greenWidth = rect.size.width;
        }
        CGContextMoveToPoint(context, 0, 0);
        CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);   
        
        CGRect rectangle = CGRectMake((CGFloat)BAR_X_OFFSET,(CGFloat)( rect.size.height - BAR_TOTAL_HEIGHT ) / 2.0 + BAR_TEXT_Y_OFFSET + BAR_TEXT_HEIGHT,(CGFloat)greenWidth,(CGFloat)BAR_HEIGHT);
        CGContextAddRect(context, rectangle);
        CGContextFillRect(context, rectangle);
        CGContextStrokePath(context);
        
        //Add Text
        NSString *lblString = [NSString stringWithFormat:@"%d%%",self.percentage];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BAR_X_OFFSET + (greenWidth / 2) - (BAR_TEXT_WIDTH / 2), rectangle.origin.y - BAR_TEXT_Y_OFFSET - BAR_TEXT_HEIGHT, BAR_TEXT_WIDTH, BAR_TEXT_HEIGHT)];
        label.text = lblString;
        label.font = [SFAUtils applicationFontWithSize:8.0];
        label.textColor = [UIColor blackColor];
        label.textAlignment = UITextAlignmentCenter;        
        label.backgroundColor = [UIColor clearColor]; 
        [self addSubview:label];   
    }
    
    //Draw Red Bar
    if(redWidth > 0)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, (CGFloat)BAR_LINE_WIDTH);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);    
        
        if(redWidth > rect.size.width )
        {
            redWidth = rect.size.width;
        }
        CGContextMoveToPoint(context, greenWidth, 0);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);   
        
        CGRect rectangle = CGRectMake((CGFloat)BAR_X_OFFSET + greenWidth,(CGFloat)( rect.size.height - BAR_TOTAL_HEIGHT ) / 2.0 + BAR_TEXT_Y_OFFSET + BAR_TEXT_HEIGHT,(CGFloat)redWidth,(CGFloat)BAR_HEIGHT);
        CGContextAddRect(context, rectangle);
        CGContextFillRect(context, rectangle);
        CGContextStrokePath(context);
        
        //Add Text
        NSString *lblString = [NSString stringWithFormat:@"%d%%",( 100 - self.percentage )];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BAR_X_OFFSET + greenWidth +(redWidth / 2), rectangle.origin.y - BAR_TEXT_Y_OFFSET - BAR_TEXT_HEIGHT, BAR_TEXT_WIDTH, BAR_TEXT_HEIGHT)];
        label.text = lblString;
        label.font = [SFAUtils applicationFontWithSize:10.0];
        label.textColor = [UIColor blackColor];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor]; 
        [self addSubview:label];           
    }
    
}

// load the subviews
- (void)loadViewContentsWithFrame:(CGRect)rect
{
    [self setNeedsDisplay];
}

- (BOOL) isOpaque {
    return NO;
}

@end
