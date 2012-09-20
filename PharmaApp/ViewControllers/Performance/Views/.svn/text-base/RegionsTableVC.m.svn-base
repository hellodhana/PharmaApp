//
//  RegionsTableVC.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegionsTableVC.h"
#import "RegionsTableViewCell.h"
#import "PharmaDAO.h"
#import "BrandDO.h"
#import "SharedData.h"

@implementation RegionsTableVC
@synthesize parentBrandPerf=_parentBrandPerf;
@synthesize overAllBrandPerf=_overAllBrandPerf;
@synthesize currBrandPerf=_currBrandPerf;
@synthesize currentTitle=_currentTitle;
@synthesize currentLevel=_currentLevel;
@synthesize delegate=_delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    checkRegionName=0;
    
    if(self.currentLevel == 1)
    {
        self.navigationItem.title = @"Regions";
    }
    else if(self.currentLevel == 2)
    {
        self.navigationItem.title = @"Districts";
        UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Regions" style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonClicked:)];
        self.navigationItem.leftBarButtonItem = backBarItem;
        self.navigationItem.hidesBackButton = YES;        
    }
    else
    {
        self.navigationItem.title = @"Territories";
        UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Districts" style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonClicked:)]; 
        self.navigationItem.leftBarButtonItem = backBarItem;
        self.navigationItem.hidesBackButton = YES;
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[[self.navigationItem backBarButtonItem] setTarget:self];
    //[[self.navigationItem backBarButtonItem] setAction:@selector(backbuttonClicked)];  
    
    //self.navigationController.navigationBar.delegate = self;
    
    
}

- (void)checkRegionandUpdateTable{
    /*
     NSString *regionName=[[SharedData sharedObj] RegionData];
     NSLog(@"%@",regionName);
     
     NSInteger idx = [regionNameArray indexOfObject:regionName];
     NSLog(@"%d",idx);
      
     RegionBrandPerfDO *regionPerfDO = [[PharmaDAO sharedDAO] getPerformanceForParent:[self.regionBrandPerfDO.child objectAtIndex:idx] andBrand:self.regionBrandPerfDO.brandPerfDO.brandDO];
     
     //Call delegate with new data
     [self.delegate willDrillDown:regionPerfDO];
     
     if (regionPerfDO.child.count != 0) {
     RegionsTableVC *tableVC = [[RegionsTableVC alloc] initWithStyle:UITableViewStylePlain];
     tableVC.delegate = self.delegate;
     tableVC.regionBrandPerfDO = regionPerfDO;
     tableVC.currentLevel = self.currentLevel + 1;
     [self.navigationController pushViewController:tableVC animated:YES];
     }
     */
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
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
    return [self.currBrandPerf count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   // Return the number of rows in the section.
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RegionsTableViewCell";
    
    RegionsTableViewCell *cell = (RegionsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (RegionsTableViewCell *)currentObject;
			}
		}
    }
    
    // Loading data: the concrete entity defines how the entity data will be loaded into the cell
    DOBrandPerf *entityData = [self.currBrandPerf objectAtIndex:indexPath.row];
    
    [cell loadDataFromEntity:entityData forRow:indexPath.row];
    return cell;
}    

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row!=0){
        DOBrandPerf *selectedBrandPerf = [self.currBrandPerf objectAtIndex:indexPath.row];
        //currBrandPerf = selectedBrandPerf;
        
        //Call delegate with new data
        [self.delegate willDrillDown:selectedBrandPerf];    
        if([selectedBrandPerf.doRegion.hier intValue] >= 3)
        {
            return;
        }
        
        
        NSMutableArray *childArray = [NSMutableArray arrayWithObject:selectedBrandPerf];
        // NSLog(@"%d",[selectedBrandPerf.doRegion.hier intValue]);
        
        if ([selectedBrandPerf.doRegion.hier intValue] == 1) {
            [childArray addObjectsFromArray:[NSMutableArray arrayWithArray:[self.overAllBrandPerf filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 2) AND (self.doRegion.region == %@)", selectedBrandPerf.doRegion.region]]]];
            
        }
        else if ([selectedBrandPerf.doRegion.hier intValue] == 2) {
            [childArray addObjectsFromArray:[NSMutableArray arrayWithArray:[self.overAllBrandPerf filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 3) AND(self.doRegion.state == %@)", selectedBrandPerf.doRegion.state]]]];            
        }     
        
        if (childArray.count != 0) {
            RegionsTableVC *tableVC = [[RegionsTableVC alloc] initWithStyle:UITableViewStylePlain];
            tableVC.delegate = self.delegate;
            tableVC.parentBrandPerf = [self.currBrandPerf objectAtIndex:0];
            tableVC.currBrandPerf = childArray;
            tableVC.overAllBrandPerf=self.overAllBrandPerf;
            tableVC.currentLevel = self.currentLevel + 1;
            [self.navigationController pushViewController:tableVC animated:YES];
        }
    }
}


-(IBAction) backbuttonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate willDrillUp:self.parentBrandPerf];
}


- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item
{
    [self.delegate willDrillUp:self.parentBrandPerf];
}
@end
