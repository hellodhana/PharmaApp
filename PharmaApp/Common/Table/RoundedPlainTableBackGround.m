//
//  RoundedPlainTableBackGround.m
//  DeloitteSalesTax
//
//  Created by klala on 8/8/11.
//  Copyright 2011 Deloitte. All rights reserved.
//

#import "RoundedPlainTableBackGround.h"
#import "SFAKeyboardManager.h"

#define RECTANGLE_FILL_COLOR [UIColor clearColor]
#define RECTANGLE_BORDER_COLOR [UIColor blackColor]
#define ROUND_SIZE 10
#define TITLE_PADDING_Y 7
#define TITLE_PADDING_X 20

#define TITLE_WIDTH 70
#define TITLE_ORDER_VALUE_WIDTH 100
#define TITLE_LABEL_FONT_SIZE 10
#define ORDER_VALUE_LABEL_FONT_SIZE 11

#define TITLE_BUTTON_WIDTH 30
#define TITLE_BUTTON_HEIGHT 20
#define SEARCH_FIELD_WIDTH 300
#define SEARCH_BUTTON_WIDTH 60
#define SEARCH_RESET_BUTTON_WIDTH 35
#define SEARCH_FIELD_PADDING_X 5

#define DEFAULT_SEARCH_ORDER_VALUE @"Description"

static void addRoundedRectToPath(CGContextRef context, CGRect rect,
								 float ovalWidth,float ovalHeight);

@implementation RoundedPlainTableBackGround
@synthesize title=_title;
@synthesize titleView=_titleView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
//    CGContextRef c = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(c, [RECTANGLE_FILL_COLOR CGColor]);
//    CGContextSetStrokeColorWithColor(c, [RECTANGLE_BORDER_COLOR CGColor]);
//    CGContextSetLineWidth(c, 0.5);
//	
//    CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
//    CGFloat miny = CGRectGetMinY(rect) , midy = CGRectGetMidY(rect) , maxy = CGRectGetMaxY(rect) ;
//    CGContextMoveToPoint(c, minx, midy);
//    CGContextAddArcToPoint(c, minx, miny, midx, miny, ROUND_SIZE);
//    CGContextAddArcToPoint(c, maxx, miny, maxx, midy, ROUND_SIZE);
//    CGContextAddArcToPoint(c, maxx, maxy, midx, maxy, ROUND_SIZE);
//    CGContextAddArcToPoint(c, minx, maxy, minx, midy, ROUND_SIZE);
//    
//    // Close the path
//    CGContextClosePath(c);
//    // Fill & stroke the path
//    CGContextDrawPath(c, kCGPathFillStroke);  
}


- (id)initWithTitle:(NSString *)tableTitle frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = tableTitle;
        self.frame = frame;
        [self loadViewContentsWithFrame:frame];
    }
    return self;
}

- (id)initWithTitleView:(UIView *)titleView frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleView = titleView;
        self.frame = frame;
        [self loadViewContentsWithFrame:frame];
    }
    return self;
}

- (BOOL) isOpaque {
    return NO;
}

// load the subviews
- (void)loadViewContentsWithFrame:(CGRect)rect
{
    if(self.titleView != nil)
    {  
        [self addSubview:self.titleView];
    }
    else
    {    
    UIImageView *imgTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, GENERIC_TABLE_TITLE_HEIGHT)];
    imgTitle.image = [UIImage imageNamed:@"activities_blue_bar_icon.png"];
    [self addSubview:imgTitle];
        
        CGSize titleLabelSize = [self.title sizeWithFont:[SFAUtils applicationFontWithSize:TITLE_LABEL_FONT_SIZE]];
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_PADDING_X, TITLE_PADDING_Y, titleLabelSize.width, GENERIC_TABLE_TITLE_HEIGHT - TITLE_PADDING_Y * 2)];
        lblTitle.text = self.title;
        lblTitle.font = [SFAUtils applicationFontWithSize:TITLE_LABEL_FONT_SIZE];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.backgroundColor = [UIColor clearColor];        
        [self addSubview:lblTitle];
    }
}


@end
