//
//  RBAppDelegate.m
//  ROSViewer
//
//  Created by Rachel Brindle on 8/16/13.
//  Copyright (c) 2013 Rachel Brindle. All rights reserved.
//

#import "RBAppDelegate.h"

#import "rosobjc.h"
#import "ROSGenMsg.h"

#import "RBServerSelectorViewController.h"

@implementation RBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *nc = [[UINavigationController alloc] init];
    nc.navigationBar.barStyle = UIBarStyleBlack;
    
    NSArray *foo = @[[ROSMsgstd_msgsBool class], [ROSMsgstd_msgsDuration class], [ROSMsgstd_msgsFloat32 class], [ROSMsgstd_msgsFloat64 class], [ROSMsgstd_msgsInt16 class], [ROSMsgstd_msgsInt32 class], [ROSMsgstd_msgsInt64 class], [ROSMsgstd_msgsInt8 class], [ROSMsgstd_msgsString class], [ROSMsgstd_msgsTime class], [ROSMsgstd_msgsUInt16 class], [ROSMsgstd_msgsUInt32 class], [ROSMsgstd_msgsUInt64 class], [ROSMsgstd_msgsUInt8 class]];
    
    [[ROSCore sharedCore] registerMessageClasses:foo];
    
    RBServerSelectorViewController *vc = [[RBServerSelectorViewController alloc] init];
    [nc pushViewController:vc animated:NO];
    self.window.rootViewController = nc;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
