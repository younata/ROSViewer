//
//  RBPublisherViewController.m
//  ROSViewer
//
//  Created by Rachel Brindle on 8/19/13.
//  Copyright (c) 2013 Rachel Brindle. All rights reserved.
//

#import "RBPublisherViewController.h"
#import "rosobjc.h"

@interface RBPublisherViewController ()

@end

@implementation RBPublisherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_topic == nil && _messageType == nil) {
        _topic = @"/test";
        _messageType = @"std_msgs/string";
    }
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    topicField = [[UITextField alloc] initWithFrame:CGRectMake(w/2-120, 20, 240, 20)];
    topicField.placeholder = @"/test";
    
    messageTypes = [[ROSCore sharedCore] getKnownMessageTypes];
    
    datasources = @[@"Text Input"];
    
    tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, w, h-60)];
    tv.delegate = self;
    tv.dataSource = self;
    
    
    [self.view addSubview:topicField];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        _messageType = [messageTypes objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1) {
        _datasource = [datasources objectAtIndex:indexPath.row];
    }
}

#pragma mark - UITableViewDatasource

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [datasources count] != 0 ? 2 : 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [messageTypes count];
    else if (section == 1)
        return [datasources count];
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"Cell";

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    
    NSArray *source;
    
    if (indexPath.section == 0) {
        source = messageTypes;
    } else if (indexPath.section == 1) {
        source = datasources;
    }
    cell.textLabel.text = [source objectAtIndex:indexPath.row];
    
    return cell;
}

@end

