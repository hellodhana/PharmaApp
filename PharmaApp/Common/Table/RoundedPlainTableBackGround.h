//
//  RoundedPlainTableBackGround.h
//  DeloitteSalesTax
//
//  Created by klala on 8/8/11.
//  Copyright 2011 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#define GENERIC_TABLE_TITLE_HEIGHT 40
#define GENERIC_TABLE_SMALL_TITLE_HEIGHT 30

@interface RoundedPlainTableBackGround : UIView {
        NSString *_title;
        UIView *_titleView;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIView *titleView;

- (id)initWithTitle:(NSString *)tableTitle frame:(CGRect)frame;
- (id)initWithTitleView:(UIView *)titleView frame:(CGRect)frame;
- (void)loadViewContentsWithFrame:(CGRect)rect;


@end
