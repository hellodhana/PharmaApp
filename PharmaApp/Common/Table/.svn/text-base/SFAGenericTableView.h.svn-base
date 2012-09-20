//
//  SFAGenericTableView.h
//  SFA
//
//  Created by Federico Lagarmilla on 4/27/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFACustomRoundedTableBackground.h"
#import "SFAGenericTableSortTableVC.h"
#import "SFAGenericTableProtocols.h"

@protocol SFAGenericTableDelegate

- (void)selectedEntity:(NSObject *)entity forRow:(int)row;


@end

@interface SFAGenericTableView : UIView <UITableViewDelegate, UITableViewDataSource, SFAGenericTableSearchBarDelegate, SFASortTableSelectorProtocol>{
    NSMutableArray *_items;
    NSMutableArray *_searchItems;
    UITableView *_table;
    NSString *_cellIdentifier;
    BOOL _isSearching;
    NSString *_title;
    UIView *_titleView;
    NSArray *_sortKeys;
    UIPopoverController *_popoverController;
    SFAGenericTableSortTableVC *_tableSelectorView;
    SFACustomRoundedTableBackground *_tableBackground;
    NSObject<SFAGenericTableDelegate> *_genericDelegate;
    CGFloat _tableRowHeight;
}
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSString *cellIdentifier;
@property (nonatomic, retain) NSObject<SFAGenericTableDelegate> *genericDelegate;
@property (nonatomic, assign) CGFloat tableRowHeight;

- (id)initWithItems:(NSMutableArray *)listItems frame:(CGRect)tableFrame;
- (id)initWithItems:(NSMutableArray *)listItems title:(NSString *)tableTitle frame:(CGRect)tableFrame;
- (id)initWithItems:(NSMutableArray *)listItems titleView:(UIView *)titleView frame:(CGRect)tableFrame;
- (id)initWithItems:(NSMutableArray *)listItems title:(NSString *)tableTitle frame:(CGRect)tableFrame
   searchSortNeeded:(BOOL)searchSortNeeded;
- (id)initWithItems:(NSMutableArray *)listItems titleView:(UIView *)titleView frame:(CGRect)tableFrame
   searchSortNeeded:(BOOL)searchSortNeeded;
- (id)initWithItems:(NSMutableArray *)listItems titleView:(UIView *)titleView frame:(CGRect)tableFrame withRowHeight:(CGFloat) rowHeight searchSortNeeded:(BOOL)searchSortNeeded;
- (void)reloadData:(NSMutableArray *)listItems;
@end
