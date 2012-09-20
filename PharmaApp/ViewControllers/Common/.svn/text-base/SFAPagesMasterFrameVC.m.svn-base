//
//  SFAPagesMasterFrameVC.m
//  SFA
//
//  Created by Martin Heras on 3/29/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAPagesMasterFrameVC.h"

@interface SFAPagesMasterFrameVC ()

@property (nonatomic, retain) UIScrollView *pagesView;

@end

@implementation SFAPagesMasterFrameVC

@synthesize pagesView = _pagesView;

- (id)init 
{
    self = [super init];
    if (self) {
        _pagesColumns = _pagesRows = _currentPageRow = _currentPageColumn = -1;
    }
    return self;
}

- (void)addView:(UIView *)aView atRow:(NSInteger)row atColumn:(NSInteger)column
{
    NSInteger pagesWidth = CGRectGetWidth(_pagesView.frame);
    NSInteger pagesHeight = CGRectGetHeight(_pagesView.frame);
    if (row > _pagesRows || column > _pagesColumns) {
        _pagesRows = row > _pagesRows ? row : _pagesRows;
        _pagesColumns = column > _pagesColumns ? column : _pagesColumns;
        _pagesView.contentSize = CGSizeMake(pagesWidth * (1 + _pagesColumns), pagesHeight * (1 + _pagesRows));
    }
    aView.frame = CGRectMake(pagesWidth * column, pagesHeight * row, pagesWidth, pagesHeight);
    aView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    [_pagesView addSubview:aView];
    
    if (_currentPageRow == -1 && _currentPageColumn == -1) {
        _currentPageRow = _currentPageColumn = 0;
    }
}

- (void)dealloc
{

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation 
{
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    NSInteger pagesWidth = CGRectGetWidth(_pagesView.frame);
    NSInteger pagesHeight = CGRectGetHeight(_pagesView.frame);
    _pagesView.contentSize = CGSizeMake(pagesWidth * (1 + _pagesColumns), pagesHeight * (1 + _pagesRows));
    [_pagesView setContentOffset:CGPointMake(_currentPageColumn * pagesWidth, _currentPageRow * pagesHeight) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pagesWidth = CGRectGetWidth(_pagesView.frame);
    NSInteger pagesHeight = CGRectGetHeight(_pagesView.frame);
    _currentPageColumn = _pagesView.contentOffset.x / pagesWidth;
    _currentPageRow = _pagesView.contentOffset.y / pagesHeight;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *aPagesView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame))];
    self.pagesView = aPagesView;
    _pagesView.delegate = self;
    
    _pagesView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _pagesView.pagingEnabled = YES;
    _pagesView.directionalLockEnabled = YES;
    _pagesView.bounces = NO;
    [_contentView addSubview:_pagesView];
    _pagesView.bounces = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.pagesView = nil;
}

@end
