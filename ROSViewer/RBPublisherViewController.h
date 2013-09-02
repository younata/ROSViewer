//
//  RBPublisherViewController.h
//  ROSViewer
//
//  Created by Rachel Brindle on 8/19/13.
//  Copyright (c) 2013 Rachel Brindle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rosobjc.h"

@interface RBPublisherViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITextField *topicField;
    UITableView *tv;
    
    UITextField *message;
    
    NSArray *datasources;
    NSArray *messageTypes;
    __block BOOL run;
}

@property (nonatomic, strong) NSString *topic;
@property (nonatomic, strong) NSString *messageType;
@property (nonatomic, strong) NSString *datasource;
@property (nonatomic, weak) ROSNode *node;

-(void)announceMessagePublication;

@end