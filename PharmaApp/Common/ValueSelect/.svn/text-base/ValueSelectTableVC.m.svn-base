//
//  ValueSelectTableVC.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ValueSelectTableVC.h"

#define TABLE_ROW_HEIGHT 40
#define TABLE_HEIGHT_PADDING 30
#define TABLE_FONT_HEIGHT 15
#define TABLE_WIDTH 200

@implementation ValueSelectTableVC
@synthesize values = _values;
@synthesize delegate = _delegate;
@synthesize sender = _sender;

- (id)initWithValues:(NSMutableArray *)values andSender:(NSObject *)sender
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.values = values;
        self.sender = sender;
    }
    return self;
}

- (void)reloadTableValues:(NSMutableArray *)newValues andSender:(NSObject *)sender
{
    self.values = newValues;
    self.sender = sender;
    [self.tableView reloadData];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
    self.contentSizeForViewInPopover = CGSizeMake(TABLE_WIDTH, TABLE_ROW_HEIGHT * self.values.count);
    
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
    return self.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    DOValueSelect *selectedDO = [self.values objectAtIndex:indexPath.row];
    cell.textLabel.text = [selectedDO getValueSelectDescription];
    //(NSString *)[sort valueForKey:SORT_DICTIONARY_USER_KEY];
    cell.textLabel.font = [SFAUtils applicationFontWithSize:TABLE_FONT_HEIGHT];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate valueSelected:[self.values objectAtIndex:indexPath.row] forSender:self.sender];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
	return TABLE_ROW_HEIGHT;
}

@end
