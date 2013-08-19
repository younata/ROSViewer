//
//  RBServerSelectorViewController.m
//  ROSViewer
//
//  Created by Rachel Brindle on 8/16/13.
//  Copyright (c) 2013 Rachel Brindle. All rights reserved.
//

#import "RBServerSelectorViewController.h"

#import "RBMainMenuViewController.h"

@interface RBServerSelectorViewController ()

@end

@implementation RBServerSelectorViewController

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
	// Do any additional setup after loading the view.
    
    NSString *s = [[NSUserDefaults standardUserDefaults] objectForKey:@"ROS_MASTER_URI"];
    if (s != nil) {
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(showMainMenu)];
        [[self navigationItem] setRightBarButtonItem:bbi];
    }
    
    //CGFloat h = self.view.frame.size.height;
    CGFloat w = self.view.frame.size.width;
    tf = [[UITextField alloc] initWithFrame:CGRectMake(w/2 - 120, 20, 240, 40)];
    tf.borderStyle = UITextBorderStyleBezel;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.delegate = self;
    if (s != nil)
        tf.text = s;
    
    //tf.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"ROSViewer";
    
    [self.view addSubview:tf];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showMainMenu
{
    
    [[self navigationController] pushViewController:[[RBMainMenuViewController alloc] init] animated:YES];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *s = textField.text;
    NSURL *u = [NSURL URLWithString:s];
    if (u == nil) {
        [[self navigationItem] setRightBarButtonItem:nil];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:s forKey:@"ROS_MASTER_URI"];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(showMainMenu)];
    
    [[self navigationItem] setRightBarButtonItem:bbi];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textFieldDidEndEditing:textField];
    return YES;
}

@end
