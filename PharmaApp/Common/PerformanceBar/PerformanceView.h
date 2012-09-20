//
//  PerformanceView.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAUtils.h"

@interface PerformanceView : UIView

- (id)initWithFrame:(CGRect)frame andPercentage:(int)per andStyle:(int)style;
- (id)initWithFrame:(CGRect)frame andPercentage:(int)per text:(NSString *)text andStyle:(int)style;
@end
