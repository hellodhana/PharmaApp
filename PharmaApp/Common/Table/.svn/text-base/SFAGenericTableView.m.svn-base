//
//  SFAGenericTableView.m
//  SFA
//
//  Created by Federico Lagarmilla on 4/27/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAGenericTableView.h"
#import "SFAGenericTableCell.h"
#import "SFACustomRoundedTableBackground.h"
#import "RoundedPlainTableBackGround.h"

#define GENERIC_TABLE_ROW_HEIGHT 20 
#define GENERIC_TABLE_VIEW_OFFSET 20
#define GENERIC_TABLE_PAGING_OFFSET 20
#define GENERIC_TABLE_CELL_FILL_COLOR [UIColor blueColor]
#define GENERIC_TABLE_BORDER_COLOR [UIColor blackColor]


@interface SFAGenericTableView ()

@property (nonatomic, retain) NSMutableArray *searchItems;
@property (nonatomic, assign) BOOL isSearching;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIView *titleView;
@property (nonatomic, retain) NSArray *sortKeys;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) SFACustomRoundedTableBackground *tableBackground;
@property (nonatomic, retain) SFAGenericTableSortTableVC *tableSelectorView;

- (void)searchEntities:(NSString *)searchValue;
- (void)sortByKey:(NSString *)sortKey;
- (void)loadViewContentsWithFrame:(CGRect)rect searchSortNeeded:(BOOL)searchSortNeeded;

@end

@implementation SFAGenericTableView
@synthesize items = _items;
@synthesize searchItems = _searchItems;
@synthesize table = _table;
@synthesize isSearching = _isSearching;
@synthesize cellIdentifier = _cellIdentifier;
@synthesize title = _title;
@synthesize sortKeys = _sortKeys;
@synthesize popoverController = _popoverController;
@synthesize tableSelectorView = _tableSelectorView;
@synthesize tableBackground = _tableBackground;
@synthesize genericDelegate = _genericDelegate;
@synthesize titleView = _titleView;
@synthesize tableRowHeight=_tableRowHeight;

#pragma mark -
#pragma mark Initialization

- (id)initWithItems:(NSMutableArray *)listItems frame:(CGRect)tableFrame
{
    self = [super initWithFrame:tableFrame];
    if (self) {
        self.frame = tableFrame;
        self.items = listItems;
    }
    return self;
}

- (id)initWithItems:(NSMutableArray *)listItems title:(NSString *)tableTitle frame:(CGRect)tableFrame
{
    self = [super initWithFrame:tableFrame];
    if (self) {
        self.frame = tableFrame;
        self.items = listItems;
        self.title = tableTitle;
        self.tableRowHeight = GENERIC_TABLE_ROW_HEIGHT;
        [self loadViewContentsWithFrame:tableFrame searchSortNeeded:YES];
    }
    return self;
}

- (id)initWithItems:(NSMutableArray *)listItems titleView:(UIView *)titleView frame:(CGRect)tableFrame
{
    self = [super initWithFrame:tableFrame];
    if (self) {
        self.frame = tableFrame;
        self.items = listItems;
        self.titleView = titleView;
        self.tableRowHeight = GENERIC_TABLE_ROW_HEIGHT;
        [self loadViewContentsWithFrame:tableFrame searchSortNeeded:YES];
    }
    return self;
    
}

- (id)initWithItems:(NSMutableArray *)listItems title:(NSString *)tableTitle frame:(CGRect)tableFrame
searchSortNeeded:(BOOL)searchSortNeeded
{
    self = [super initWithFrame:tableFrame];
    if (self) {
        self.frame = tableFrame;
        self.items = listItems;
        self.title = tableTitle;
        self.tableRowHeight = GENERIC_TABLE_ROW_HEIGHT;
        if (searchSortNeeded == YES)
        {    
            [self loadViewContentsWithFrame:tableFrame searchSortNeeded:YES];
        }
        else
        {
            [self loadViewContentsWithFrame:tableFrame searchSortNeeded:NO];
        }
    }
    return self;
}

- (id)initWithItems:(NSMutableArray *)listItems titleView:(UIView *)titleView frame:(CGRect)tableFrame
   searchSortNeeded:(BOOL)searchSortNeeded
{
    self = [super initWithFrame:tableFrame];
    if (self) {
        self.frame = tableFrame;
        self.items = listItems;
        self.titleView = titleView;
        self.tableRowHeight = GENERIC_TABLE_ROW_HEIGHT;
        if (searchSortNeeded == YES)
        {    
            [self loadViewContentsWithFrame:tableFrame searchSortNeeded:YES];
        }
        else
        {
            [self loadViewContentsWithFrame:tableFrame searchSortNeeded:NO];
        }
    }
    return self;
}

- (id)initWithItems:(NSMutableArray *)listItems titleView:(UIView *)titleView frame:(CGRect)tableFrame withRowHeight:(CGFloat) rowHeight searchSortNeeded:(BOOL)searchSortNeeded;
{
    self = [super initWithFrame:tableFrame];
    if (self) {
        self.frame = tableFrame;
        self.items = listItems;
        self.titleView = titleView;
        self.tableRowHeight = rowHeight;
        if (searchSortNeeded == YES)
        {    
            [self loadViewContentsWithFrame:tableFrame searchSortNeeded:YES];
        }
        else
        {
            [self loadViewContentsWithFrame:tableFrame searchSortNeeded:NO];
        }
    }
    return self;
    
}
// load the subviews
- (void)loadViewContentsWithFrame:(CGRect)rect searchSortNeeded:(BOOL)searchSortNeeded
{    
    
    if(searchSortNeeded == YES)
    {    
            [SFAUtils addCustomGradientToView:self fromColor:[UIColor whiteColor] toColor:[UIColor lightGrayColor]]; 
        
    self.tableBackground = [[SFACustomRoundedTableBackground alloc] initWithTitle:self.title delegate:self frame:CGRectMake(self.frame.origin.x + GENERIC_TABLE_VIEW_OFFSET, self.frame.origin.y + GENERIC_TABLE_VIEW_OFFSET , self.frame.size.width - 2 * GENERIC_TABLE_VIEW_OFFSET, self.frame.size.height - 2 * GENERIC_TABLE_VIEW_OFFSET - GENERIC_TABLE_PAGING_OFFSET)];
        
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.origin.x + GENERIC_TABLE_VIEW_OFFSET, self.frame.origin.y + GENERIC_TABLE_VIEW_OFFSET + GENERIC_TABLE_TITLE_HEIGHT, self.frame.size.width - 2 * GENERIC_TABLE_VIEW_OFFSET - 20, self.frame.size.height - 2 * GENERIC_TABLE_VIEW_OFFSET - GENERIC_TABLE_PAGING_OFFSET - GENERIC_TABLE_TITLE_HEIGHT) style:UITableViewStylePlain];
        
            self.table.backgroundColor = [UIColor clearColor];
    }
    else
    {
        if (self.titleView !=nil) {
            self.tableBackground = [[RoundedPlainTableBackGround alloc] initWithTitleView:self.titleView frame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.titleView.frame.size.width - 2, self.titleView.frame.size.height - 5)];
            
            self.table = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.titleView.frame.size.height, self.frame.size.width - 2, self.frame.size.height - self.titleView.frame.size.height - 5) style:UITableViewStylePlain];
            self.table.backgroundColor = [UIColor clearColor];
            
        }
        else
        {    
            self.tableBackground = [[RoundedPlainTableBackGround alloc] initWithTitle:self.title frame:CGRectMake(self.frame.origin.x + 3, self.frame.origin.y + 5 , self.frame.size.width - GENERIC_TABLE_VIEW_OFFSET + 3, self.frame.size.height - GENERIC_TABLE_VIEW_OFFSET + 6)];
            
            self.table = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.origin.x + 5 , self.frame.origin.y + GENERIC_TABLE_VIEW_OFFSET + GENERIC_TABLE_SMALL_TITLE_HEIGHT - 5, self.frame.size.width - GENERIC_TABLE_VIEW_OFFSET, self.frame.size.height - GENERIC_TABLE_VIEW_OFFSET  - GENERIC_TABLE_SMALL_TITLE_HEIGHT - 5) style:UITableViewStylePlain];
        }

        
    }
    [self addSubview:self.tableBackground];

    self.table.layer.cornerRadius = 5;
    self.table.delegate = self;
    self.table.dataSource = self;

    self.table.bounces = NO;
    self.table.separatorColor = [UIColor darkGrayColor];
    self.table.tag = 0;
    if (self.items && self.items.count > 0 && searchSortNeeded == YES) {
        NSObject <SFASortValuesProtocol> *sortObject = (NSObject <SFASortValuesProtocol> *)[self.items objectAtIndex:0];   
        NSMutableArray *keys = [sortObject sortValues];
        if (keys && keys.count > 0) {
            NSDictionary *defaultSort = [keys objectAtIndex:0];
            [self sortByKey:[defaultSort valueForKey:SORT_DICTIONARY_SORT_KEY]];
            [self.tableBackground updateSortValue:[defaultSort valueForKey:SORT_DICTIONARY_USER_KEY]];
        }
    }
    [self addSubview:self.table];
}

- (void)reloadData:(NSMutableArray *)listItems;
{
    self.items = listItems;
    
    [self.table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    if (self.isSearching) {
        return self.searchItems.count;
    } else {
        return self.items.count;    
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    SFAGenericTableCell *cell = (SFAGenericTableCell *)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
     
    if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle]loadNibNamed:self.cellIdentifier owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (SFAGenericTableCell *)currentObject;
			}
		}
        // Loading data: the concrete entity defines how the entity data will be loaded into the cell
        NSObject <SFASearcheableEntityProtocol> *entityData;
        if (self.isSearching) {
            entityData = [self.searchItems objectAtIndex:indexPath.row];
        } else {
            entityData = [self.items objectAtIndex:indexPath.row];
        }
        cell.delegate=(id)self.genericDelegate;
        
        [cell loadDataFromEntity:entityData forRow:indexPath.row];
    }
    return cell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // paint selection
    if (self.isSearching) {
        [self.genericDelegate selectedEntity:[self.searchItems objectAtIndex:indexPath.row] forRow:indexPath.row];
    } else {
        [self.genericDelegate selectedEntity:[self.items objectAtIndex:indexPath.row] forRow:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
	return self.tableRowHeight;
}

#pragma mark SFASearcheableEntityDelegate

- (void)searchText:(NSString *)text
{
    [self searchEntities:text];
}

#pragma mark -
#pragma mark SearchMethods

- (void)searchEntities:(NSString *)searchValue
{
     if (![searchValue isEqualToString:@""] && ![searchValue isEqualToString:@" "]) {
        self.isSearching = YES;
        if (self.searchItems) {
            [self.searchItems removeAllObjects];
        } else {
            self.searchItems = [[NSMutableArray alloc] init];
        }
        
        for (NSObject <SFASearcheableEntityProtocol> *entity in self.items) {
            if ([entity hasSearchingValue:searchValue]) {
                [self.searchItems addObject:entity];
            }
        }        
    } else {
        self.isSearching = NO;
    }
    [self.table reloadData];
}

- (void)disableSearch
{
    self.isSearching = NO;
    [self.table reloadData];
}

#pragma mark -
#pragma mark Sort Table

- (void)sortByKey:(NSString *)sortKey
{
    NSSortDescriptor *nickSorter = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
    [self.items sortUsingDescriptors:[NSArray arrayWithObject:nickSorter]];        
    [self.searchItems sortUsingDescriptors:[NSArray arrayWithObject:nickSorter]];
    [self.table reloadData];
}

- (void)sortKeysOptionDisplay:(id)sender;
{
    UIView *senderView = (UIView *)sender;
    CGRect popoverReference = CGRectMake(senderView.frame.origin.x + senderView.frame.size.width / 1.5, senderView.frame.origin.y + senderView.frame.size.height, senderView.frame.size.width, senderView.frame.size.height);   
    if (self.items && self.items.count > 0) {
        NSObject <SFASortValuesProtocol> *sortObject = (NSObject <SFASortValuesProtocol> *)[self.items objectAtIndex:0];   
        NSMutableArray *keys = [sortObject sortValues];
        if (keys) {
            if (!self.tableSelectorView) {
                self.tableSelectorView = [[SFAGenericTableSortTableVC alloc] initWithValues:keys];
            } else {
                [self.tableSelectorView reloadTableValues:keys];
            }
            self.tableSelectorView.delegate = self;
            if (!self.popoverController) {
                self.popoverController = [[UIPopoverController alloc] 
                                           initWithContentViewController:self.tableSelectorView];               
            }
            [self.popoverController presentPopoverFromRect:popoverReference inView:self
                                  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
    } else {
        self.sortKeys = nil;
    }  
}

- (void)sortValueSelected:(NSDictionary *)value
{
    [self.popoverController dismissPopoverAnimated:YES];
    [self.tableBackground updateSortValue:[value valueForKey:SORT_DICTIONARY_USER_KEY]];
    [self sortByKey:[value valueForKey:SORT_DICTIONARY_SORT_KEY]];
}

#pragma mark -
#pragma mark Memory Management


@end


