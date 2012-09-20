//
//  GenericTreeView.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericTreeView.h"
#import "RoundedPlainTableBackGround.h"

#define GENERIC_TABLE_ROW_HEIGHT 20 
#define GENERIC_TABLE_VIEW_OFFSET 20
#define GENERIC_TABLE_PAGING_OFFSET 20
#define GENERIC_TABLE_CELL_FILL_COLOR [UIColor blueColor]
#define GENERIC_TABLE_BORDER_COLOR [UIColor blackColor]

@interface GenericTreeView()

- (void)loadViewContentsWithFrame:(CGRect)rect titleView:(UIView *)titleView orTitle:(NSString *)title;

@end

@implementation GenericTreeView
@synthesize rootNode=_rootNode;
@synthesize table=_table;
@synthesize tableBackground=_tableBackground;
@synthesize cellIdentifier=_cellIdentifier;

- (id)initWithRootNode:(GenericTreeNode *)rootNode titleView:(UIView *)titleView frame:(CGRect)tableFrame
{
    self = [super init];
    if(self)
    {
        self.frame = tableFrame;
        self.rootNode = rootNode;
        [self loadViewContentsWithFrame:tableFrame titleView:titleView orTitle:nil];
    }
    
    return self;
}

- (id)initWithRootNode:(GenericTreeNode *)rootNode NSString:(NSString *)title frame:(CGRect)tableFrame
{
    self = [super init];
    if(self)
    {
        self.frame = tableFrame;        
        self.rootNode = rootNode;
        [self loadViewContentsWithFrame:tableFrame titleView:nil orTitle:title];
    }
    
    return self;
}

- (void)loadViewContentsWithFrame:(CGRect)rect titleView:(UIView *)titleView orTitle:(NSString *)title
{
    
    if (titleView !=nil) {
        self.tableBackground = [[RoundedPlainTableBackGround alloc] initWithTitleView:titleView frame:CGRectMake(self.frame.origin.x, self.frame.origin.y, titleView.frame.size.width - 2, titleView.frame.size.height - 5)];
        
        self.table = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + titleView.frame.size.height, self.frame.size.width - 2, self.frame.size.height - titleView.frame.size.height - 5) style:UITableViewStylePlain];
        self.table.backgroundColor = [UIColor clearColor];
        
    }
    else
    {    
        self.tableBackground = [[RoundedPlainTableBackGround alloc] initWithTitle:title frame:CGRectMake(self.frame.origin.x + 3, self.frame.origin.y + 5 , self.frame.size.width - GENERIC_TABLE_VIEW_OFFSET + 3, self.frame.size.height - GENERIC_TABLE_VIEW_OFFSET + 6)];
        
        self.table = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.origin.x + 5 , self.frame.origin.y + GENERIC_TABLE_VIEW_OFFSET + GENERIC_TABLE_SMALL_TITLE_HEIGHT - 5, self.frame.size.width - GENERIC_TABLE_VIEW_OFFSET, self.frame.size.height - GENERIC_TABLE_VIEW_OFFSET  - GENERIC_TABLE_SMALL_TITLE_HEIGHT - 5) style:UITableViewStylePlain];
    }
    
    [self addSubview:self.tableBackground];
    
    self.table.layer.cornerRadius = 5;
    self.table.delegate = self;
    self.table.dataSource = self;
    
    self.table.bounces = NO;
    self.table.separatorColor = [UIColor darkGrayColor];
    self.table.tag = 0;

    [self addSubview:self.table];    
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
    return [self.rootNode descendantCount];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//	
//   	MyTreeNode *node = [[treeNode flattenElements] objectAtIndex:indexPath.row + 1];
//	MyTreeViewCell *cell = [[MyTreeViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//												 reuseIdentifier:CellIdentifier 
//														   level:[node levelDepth] - 1 
//														expanded:node.inclusive];   
        
    GenericTreeCell *cell = (GenericTreeCell *)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    
    if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle]loadNibNamed:self.cellIdentifier owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (GenericTreeCell *)currentObject;
			}
		}
    }
    if(cell)
    {
        i++;
        GenericTreeNode *node = [[self.rootNode flattenElements] objectAtIndex:indexPath.row + 1];  
        [cell loadTreeDataWithLevel:[node levelDepth] - 1 andExpanded:node.inclusive];
      //  NSLog(@"cell tag : %d",i);
        [node setIndex:i];
        [cell loadDataFromNode:node];
    }
    return cell;    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	GenericTreeNode *node = [[self.rootNode flattenElements] objectAtIndex:indexPath.row + 1];
	if (!node.hasChildren) return;
	
	node.inclusive = !node.inclusive;	
	[self.rootNode flattenElementsWithCacheRefresh:YES];
	[tableView reloadData];
}
@end
