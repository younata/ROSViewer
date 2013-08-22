//
//  RBPublisherViewController.h
//  ROSViewer
//
//  Created by Rachel Brindle on 8/19/13.
//  Copyright (c) 2013 Rachel Brindle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBPublisherViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITextField *topicField;
    UITableView *tv;
    
    NSArray *datasources;
    NSArray *messageTypes;
}

@property (nonatomic, strong) NSString *topic;
@property (nonatomic, strong) NSString *messageType;
@property (nonatomic, strong) NSString *datasource;

-(void)announceMessagePublication;

@end