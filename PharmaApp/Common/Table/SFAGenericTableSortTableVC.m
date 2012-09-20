//
//  SFAGenericTableSortTableVC.m
//  SFA
//
//  Created by Federico Lagarmilla on 5/3/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAGenericTableSortTableVC.h"

#define SORT_TABLE_ROW_HEIGHT 50
#define SORT_TABLE_HEIGHT_PADDING 30
#define SORT_TABLE_FONT_HEIGHT 15
#define SORT_TABLE_WIDTH 250

@implementation SFAGenericTableSortTableVC
@synthesize sortValues = _sortValues;
@synthesize delegate = _delegate;

- (id)initWithValues:(NSMutableArray *)values
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.sortValues = values;
        // Custom initialization
    }
    return self;
}

- (void)reloadTableValues:(NSMutableArray *)newValues
{
    self.sortValues = newValues;
    [self.tableView reloadData];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
    self.contentSizeForViewInPopover = CGSizeMake(SORT_TABLE_WIDTH, SORT_TABLE_ROW_HEIGHT * self.sortValues.count);
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.sortValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *sort = [self.sortValues objectAtIndex:indexPath.row];
    cell.textLabel.text = sort;
    //(NSString *)[sort valueForKey:SORT_DICTIONARY_USER_KEY];
    cell.textLabel.font = [SFAUtils applicationFontWithSize:SORT_TABLE_FONT_HEIGHT];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate sortValueSelected:[self.sortValues objectAtIndex:indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
	return SORT_TABLE_ROW_HEIGHT;
}


@end
