//
//  ViewController.h
//  jsonTutorial
//
//  Created by ahmet on 22/06/15.
//  Copyright (c) 2015 ahmet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)getTop10Button:(id)sender;

@end

