//
//  ViewController.m
//  RTAcronymSearch
//
//  Created by Rahul Thota on 8/26/15.
//  Copyright (c) 2015 Rahul Thota. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "RTAcronymDataController.h"
#import "RTAcronym.h"
#import "RTAcronymSF.h"

@interface ViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (strong, nonatomic) RTAcronymSF* acronymData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.resultsTableView setTableFooterView:[UIView new]];
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
    return self.acronymData.longForms.count;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    RTAcronym* acronym = self.acronymData.longForms[section];
    return acronym.longForm;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RTAcronym* acronym = self.acronymData.longForms[section];
    
    return acronym.subLongformsArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* const kCellIdentifier = @"cellIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    RTAcronym* acronym = self.acronymData.longForms[indexPath.section];
    RTAcronym* subAcronym = acronym.subLongformsArray[indexPath.row];
    
    
    [cell.textLabel setText:subAcronym.longForm];
    
    return cell;
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    [MBProgressHUD showHUDAddedTo:self.resultsTableView animated:YES];
    
    [[RTAcronymDataController manager] retrieveAcronymDataForSF:searchBar.text OnCompletion:^(RTAcronymSF *acronymData, NSError *error) {
        [MBProgressHUD hideHUDForView:self.resultsTableView animated:YES];
        
        if (error != nil) {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Error retrieving data" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Do some thing here
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alertController addAction:ok]; // add action to uialertcontroller

            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    
        self.acronymData = acronymData;
        [self.resultsTableView reloadData];
        
        
        
    }];
}
@end
