//
//  ViewController.m
//  jsonTutorial
//
//  Created by ahmet on 22/06/15.
//  Copyright (c) 2015 ahmet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    array = [[NSMutableArray alloc]init];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"fail with error");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
    NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
    
    for (NSDictionary *diction in arrayOfEntry) {
        NSDictionary *title = [diction objectForKey:@"title"];
        NSString *label = [title objectForKey:@"label"];
        
        [array addObject:label];
    }
    [[self myTableView]reloadData];
}

- (IBAction)getTop10Button:(id)sender {
    
    [array removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/tr/rss/topsongs/limit=10/json"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection) {
        webData = [[NSMutableData alloc]init];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
}
@end
