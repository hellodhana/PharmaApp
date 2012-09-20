//
//  SFACustomRoundedTableBackground.m
//  SFA
//
//  Created by Federico Lagarmilla on 4/28/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFACustomRoundedTableBackground.h"
#import "SFAKeyboardManager.h"

#define RECTANGLE_FILL_COLOR [UIColor clearColor]
#define RECTANGLE_BORDER_COLOR [UIColor blackColor]
#define ROUND_SIZE 10
#define TITLE_PADDING_Y 7
#define TITLE_PADDING_X 20

#define TITLE_WIDTH 70
#define TITLE_ORDER_VALUE_WIDTH 100
#define TITLE_LABEL_FONT_SIZE 17
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


@interface SFACustomRoundedTableBackground ()

@property (nonatomic, retain) NSObject <SFAGenericTableSearchBarDelegate> *delegate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UILabel *lblOrderValue;
@property (nonatomic, retain) UITextField *txtSearchField;
@property (nonatomic, retain) UIButton *btnSort;

- (void)loadViewContentsWithFrame:(CGRect)rect;

@end

@implementation SFACustomRoundedTableBackground
@synthesize delegate = _delegate;
@synthesize title = _title;
@synthesize lblOrderValue = _lblOrderValue;
@synthesize txtSearchField = _txtSearchField;
@synthesize btnSort = _btnSort;


- (id)initWithTitle:(NSString *)tableTitle delegate:(NSObject <SFAGenericTableSearchBarDelegate> *)searchDelegate frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = tableTitle;
        self.delegate = searchDelegate;
        self.frame = frame;
        [self loadViewContentsWithFrame:frame];
    }
    return self;
}


- (BOOL) isOpaque {
    return NO;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(c, [RECTANGLE_FILL_COLOR CGColor]);
    CGContextSetStrokeColorWithColor(c, [RECTANGLE_BORDER_COLOR CGColor]);
    CGContextSetLineWidth(c, 0.5);
	
    CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
    CGFloat miny = CGRectGetMinY(rect) , midy = CGRectGetMidY(rect) , maxy = CGRectGetMaxY(rect) ;
    CGContextMoveToPoint(c, minx, midy);
    CGContextAddArcToPoint(c, minx, miny, midx, miny, ROUND_SIZE);
    CGContextAddArcToPoint(c, maxx, miny, maxx, midy, ROUND_SIZE);
    CGContextAddArcToPoint(c, maxx, maxy, midx, maxy, ROUND_SIZE);
    CGContextAddArcToPoint(c, minx, maxy, minx, midy, ROUND_SIZE);
		
    // Close the path
    CGContextClosePath(c);
    // Fill & stroke the path
    CGContextDrawPath(c, kCGPathFillStroke);                
}

// load the subviews
- (void)loadViewContentsWithFrame:(CGRect)rect
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
    
    NSString *orderValue = [NSString stringWithFormat:@"by %@", DEFAULT_SEARCH_ORDER_VALUE];
    CGSize orderValueLabelSize = [orderValue sizeWithFont:[SFAUtils applicationFontWithSize:ORDER_VALUE_LABEL_FONT_SIZE]];
    self.lblOrderValue = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelSize.width + TITLE_PADDING_X * 2, TITLE_PADDING_Y, orderValueLabelSize.width, GENERIC_TABLE_TITLE_HEIGHT - TITLE_PADDING_Y * 2)];
    self.lblOrderValue.text = orderValue;
    self.lblOrderValue.backgroundColor = [UIColor clearColor];
    self.lblOrderValue.font = [SFAUtils applicationFontWithSize:ORDER_VALUE_LABEL_FONT_SIZE];
    self.lblOrderValue.textAlignment = UITextAlignmentCenter;
    self.lblOrderValue.textColor = [UIColor whiteColor];
    self.btnSort = [[UIButton alloc] initWithFrame:CGRectMake(self.lblOrderValue.frame.size.width + self.lblOrderValue.frame.origin.x + TITLE_PADDING_X, TITLE_PADDING_Y * 1.5, TITLE_BUTTON_WIDTH, GENERIC_TABLE_TITLE_HEIGHT)];
    [self.btnSort setImage:[UIImage imageNamed:@"table_arrow_down_white.png"] forState:UIControlStateNormal];
    self.btnSort.imageView.contentMode = UIViewContentModeBottom;
    [self.btnSort addTarget:self action:@selector(changeSortValue:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lblTitle];
    [self addSubview:self.lblOrderValue];
    [self addSubview:self.btnSort];

    
    UITextField *txtBack = [[UITextField alloc] initWithFrame:CGRectMake(rect.size.width - SEARCH_FIELD_WIDTH - TITLE_PADDING_X, TITLE_PADDING_Y, SEARCH_FIELD_WIDTH, GENERIC_TABLE_TITLE_HEIGHT - TITLE_PADDING_Y * 2)];
    txtBack.borderStyle = UITextBorderStyleRoundedRect;
    txtBack.userInteractionEnabled = NO;
    [self addSubview:txtBack];
    
    
    UIButton *btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width - SEARCH_BUTTON_WIDTH - TITLE_PADDING_X, TITLE_PADDING_Y - 5, SEARCH_BUTTON_WIDTH, GENERIC_TABLE_TITLE_HEIGHT - TITLE_PADDING_Y * 2 + 10)];
    [btnSearch setImage:[UIImage imageNamed:@"search_bar_icon.png"] forState:UIControlStateNormal];
    
    [self addSubview:btnSearch];
    [btnSearch addTarget:self action:@selector(finishSearch) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnReset = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width - SEARCH_BUTTON_WIDTH - TITLE_PADDING_X - SEARCH_RESET_BUTTON_WIDTH, TITLE_PADDING_Y, SEARCH_RESET_BUTTON_WIDTH, GENERIC_TABLE_TITLE_HEIGHT - TITLE_PADDING_Y * 2)];
    [btnReset setImage:[UIImage imageNamed:@"dashboard_v2_reset_icon.png"] forState:UIControlStateNormal];
    [self addSubview:btnReset];
    [btnReset addTarget:self action:@selector(resetSearch) forControlEvents:UIControlEventTouchUpInside];

    
    self.txtSearchField = [[UITextField alloc] initWithFrame:CGRectMake(rect.size.width - SEARCH_FIELD_WIDTH - TITLE_PADDING_X + SEARCH_FIELD_PADDING_X, TITLE_PADDING_Y + 5, SEARCH_FIELD_WIDTH - SEARCH_RESET_BUTTON_WIDTH - SEARCH_BUTTON_WIDTH - SEARCH_FIELD_PADDING_X, GENERIC_TABLE_TITLE_HEIGHT - TITLE_PADDING_Y * 2)];
    self.txtSearchField.borderStyle = UITextBorderStyleNone;
    self.txtSearchField.font = [SFAUtils applicationFontWithSize:TITLE_LABEL_FONT_SIZE - 5];
    [self addSubview:self.txtSearchField];
    self.txtSearchField.delegate = self;
    self.txtSearchField.placeholder = [NSString stringWithFormat:@"Search %@", self.title];

}

#pragma mark -
#pragma mark Sort Values
- (void)changeSortValue:(id)sender 
{
    [self.delegate sortKeysOptionDisplay:sender];
}

- (void)updateSortValue:(NSString *)sortValue
{
    self.lblOrderValue.text = [NSString stringWithFormat:@"by %@", sortValue];
    CGSize orderValueLabelSize = [self.lblOrderValue.text sizeWithFont:[SFAUtils applicationFontWithSize:ORDER_VALUE_LABEL_FONT_SIZE]];
    self.lblOrderValue.frame = CGRectMake(self.lblOrderValue.frame.origin.x, self.lblOrderValue.frame.origin.y, orderValueLabelSize.width, self.lblOrderValue.frame.size.height);
    
    self.btnSort.frame = CGRectMake(self.lblOrderValue.frame.size.width + self.lblOrderValue.frame.origin.x + TITLE_PADDING_X, self.btnSort.frame.origin.y, TITLE_BUTTON_WIDTH, TITLE_BUTTON_HEIGHT);
}



static void addRoundedRectToPath(CGContextRef context, CGRect rect,
								 float ovalWidth,float ovalHeight)

{
    float fw, fh;
	
    if (ovalWidth == 0 || ovalHeight == 0) {// 1
        CGContextAddRect(context, rect);
        return;
    }
	
    CGContextSaveGState(context);// 2
	
    CGContextTranslateCTM (context, CGRectGetMinX(rect),// 3
						   CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);// 4
    fw = CGRectGetWidth (rect) / ovalWidth;// 5
    fh = CGRectGetHeight (rect) / ovalHeight;// 6
	
    CGContextMoveToPoint(context, fw, fh/2); // 7
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);// 8
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);// 9
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);// 10
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11
    CGContextClosePath(context);// 12
	
    CGContextRestoreGState(context);// 13
}

#pragma mark -
#pragma mark TextFiedDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self.delegate searchText:self.txtSearchField.text];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{   
    [textField resignFirstResponder]; 
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField 
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[SFAKeyboardManager sharedInstance] setIsVisible:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[SFAKeyboardManager sharedInstance] setIsVisible:NO];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [[SFAKeyboardManager sharedInstance] setIsVisible:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [[SFAKeyboardManager sharedInstance] setIsVisible:NO];
}

- (void)resetSearch
{
    self.txtSearchField.text = @"";
    [self.delegate searchText:self.txtSearchField.text];
    [self.txtSearchField resignFirstResponder];
}

     
- (void)finishSearch
{
    [self.txtSearchField resignFirstResponder];
}


#pragma mark -
#pragma mark Memory




@end
