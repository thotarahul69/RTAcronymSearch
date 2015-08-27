//
//  ViewController.m
//  RTAcronymSearch
//
//  Created by Rahul Thota on 8/26/15.
//  Copyright (c) 2015 Rahul Thota. All rights reserved.
//

#import "ViewController.h"
#import "RTAcronymDataController.h"
#import "RTAcronym.h"
#import "RTAcronymSF.h"

@interface ViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* const kCellIdentifier = @"cellIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    [cell.textLabel setText:@"TEST"];
    
    return cell;
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    [[RTAcronymDataController manager] retrieveAcronymDataForSF:searchBar.text OnCompletion:^(RTAcronymSF *acronymData, NSError *error) {
        for (RTAcronym* ac in acronymData.longForms) {
            NSLog(@"AC %@",ac.longForm);
        }
    }];
}
@end
