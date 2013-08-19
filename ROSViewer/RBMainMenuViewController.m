//
//  RBMainMenuViewController.m
//  ROSViewer
//
//  Created by Rachel Brindle on 8/16/13.
//  Copyright (c) 2013 Rachel Brindle. All rights reserved.
//

#import "RBMainMenuViewController.h"
#import "RBTopicViewController.h"

#import "rosobjc.h"
#import "ROSCore.h"

@interface RBMainMenuViewController ()
{
    ROSNode *node;
    dispatch_queue_t queue;
    NSArray *datasource;
    ROSXMLRPCC *xrc;
}

@end

@implementation RBMainMenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        ROS_MASTER_URI = [[NSUserDefaults standardUserDefaults] objectForKey:@"ROS_MASTER_URI"];
        [[ROSCore sharedCore] setUri:ROS_MASTER_URI];
        [[ROSCore sharedCore] setInitialized:YES];
        node = [[ROSCore sharedCore] createNode:@"testNode"];
    }
    return self;
}

-(void)loadData
{
    xrc = [[ROSXMLRPCC alloc] init];
    xrc.URL = [NSURL URLWithString:ROS_MASTER_URI];
    
    [xrc getSystemState:[node name] callback:^(NSArray *ret){
        //NSLog(@"%@", ret[2]);
        NSArray *foo = ret[2];
        NSArray *publishers = foo[0];
        NSArray *subscribers = foo[1];
        NSArray *services = foo[2];
        NSMutableArray *x = [[NSMutableArray alloc] init];
        NSMutableArray *y = [[NSMutableArray alloc] init];
        NSMutableArray *z = [[NSMutableArray alloc] init];
        for (NSArray *b in publishers) {
            [x addObject:b[0]];
        }
        for (NSArray *b in subscribers) {
            [y addObject:b[0]];
        }
        for (NSArray *b in services) {
            [z addObject:b[0]];
        }
        datasource = @[x,y,z];
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadData)];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [datasource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *a = datasource[indexPath.section];
    [cell.textLabel setText:[a objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - Table view delegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Publishers";
    if (section == 1)
        return @"Subscribers";
    if (section == 2)
        return @"Services";
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: this! (but, we're just testing the xmlrpc portions at the moment.
    //NSArray *x = datasource[indexPath.section];
    NSArray *a = datasource[indexPath.section];
    NSString *topic = [a objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        // We want to view it...
        
        RBTopicViewController *tvc = [[RBTopicViewController alloc] init];
        tvc.node = node;
        tvc.topic = topic;
        [self.navigationController pushViewController:tvc animated:YES];
    } else if (indexPath.section == 1) {
        // We want to publish to it...
    }
}

@end
