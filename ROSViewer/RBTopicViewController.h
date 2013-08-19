//
//  RBTopicViewController.h
//  ROSViewer
//
//  Created by Rachel Brindle on 8/17/13.
//  Copyright (c) 2013 Rachel Brindle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rosobjc.h"

@interface RBTopicViewController : UIViewController
{
    UITextView *tv;
}
@property (nonatomic, weak) ROSNode *node;
@property (nonatomic, strong) NSString *topic;

// this will echo topics...

@end
