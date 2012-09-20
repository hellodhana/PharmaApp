//
//  SFAPagesMasterFrameVC.h
//  SFA
//
//  Created by Martin Heras on 3/29/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAMasterFrameVC.h"

@interface SFAPagesMasterFrameVC : SFAMasterFrameVC <UIScrollViewDelegate> {
    UIScrollView *_pagesView;
    NSInteger _pagesRows;
    NSInteger _pagesColumns;
    NSInteger _currentPageRow;
    NSInteger _currentPageColumn;
}

- (void)addView:(UIView *)aView atRow:(NSInteger)row atColumn:(NSInteger)column;

@end
