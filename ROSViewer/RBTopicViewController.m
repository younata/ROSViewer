//
//  RBTopicViewController.m
//  ROSViewer
//
//  Created by Rachel Brindle on 8/17/13.
//  Copyright (c) 2013 Rachel Brindle. All rights reserved.
//

#import "RBTopicViewController.h"

@interface RBTopicViewController ()

@end

@implementation RBTopicViewController

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
    
    tv = [[UITextView alloc] initWithFrame:self.view.frame];
    tv.scrollEnabled = YES;
    tv.scrollsToTop = YES;
    tv.editable = NO;
    
    self.navigationItem.title = _topic;
    
    [self.view addSubview:tv];
    
    [_node subscribe:_topic callback:^(ROSMsg *m){
        id foo = [m performSelector:@selector(data)];
        NSString *d = foo;
        if ([foo respondsToSelector:@selector(stringValue)])
            d = [foo stringValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            tv.text = [tv.text stringByAppendingString:[@"\n---\n" stringByAppendingString:d]];
            [tv scrollRangeToVisible:NSMakeRange([tv.text length] - [d length], [d length])];
        });
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    tv.frame = self.view.frame;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_node shutdown:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    tv.frame = self.view.frame;
}

@end
