//
//  YMHoursViewController.m
//  YaleMobile
//
//  Created by Danqing on 1/30/13.
//  Copyright (c) 2013 Danqing Liu. All rights reserved.
//

#import "YMHoursViewController.h"
#import "YMSimpleCell.h"
#import "YMGlobalHelper.h"
#import "UIColor+YaleMobile.h"

@interface YMHoursViewController ()

@end

@implementation YMHoursViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [YMGlobalHelper addMenuButtonToController:self];
    self.types = @[@"Libraries", @"Dining - Retail Facilities", @"Gym and Recreational Facilities"];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [YMGlobalHelper setupSlidingViewControllerForController:self];
    if (self.selectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
        self.selectedIndexPath = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)menu:(id)sender
{
    [YMGlobalHelper setupMenuButtonForController:self];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *cell = [gestureRecognizer view];
    CGPoint translation = [gestureRecognizer translationInView:[cell superview]];
    if (fabsf(translation.x) > fabsf(translation.y)) return YES;
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.types.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMSimpleCell *cell;
    
    if (indexPath.row == 0) cell = (YMSimpleCell *)[tableView dequeueReusableCellWithIdentifier:@"Hours Cell 0"];
    else if (indexPath.row == 1) cell = (YMSimpleCell *)[tableView dequeueReusableCellWithIdentifier:@"Hours Cell 1"];
    else if (indexPath.row == self.types.count + 1) cell = (YMSimpleCell *)[tableView dequeueReusableCellWithIdentifier:@"Hours Footer"];
    else cell = (YMSimpleCell *)[tableView dequeueReusableCellWithIdentifier:@"Hours Cell 2"];
    
    if (indexPath.row == 0) {
        cell.name.text = @"Select a Category";
        cell.backgroundView = nil;
        cell.backgroundColor = [UIColor clearColor];
    } else if (indexPath.row == self.types.count + 1) {
        NSString *text = @"Please note: unless otherwise noted, hours listed here only refer to regular schedule. Please double check during holidays and special events.";
        cell.name.text = text;
        CGSize textSize = [text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14] constrainedToSize:CGSizeMake(280, 5000)];
        CGRect frame = cell.name.frame;
        frame.size.height = textSize.height;
        cell.userInteractionEnabled = NO;
        cell.name.frame = frame;
    } else {
        cell.name.text = [self.types objectAtIndex:indexPath.row - 1];
        cell.name.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        if (indexPath.row == 1) {
            cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"tablebg_top.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 5, 20)]];
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"tablebg_top_highlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 5, 20)]];
        } else if (indexPath.row == self.types.count) {
            cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"tablebg_bottom.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 20, 10, 20)]];
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"tablebg_bottom_highlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 20, 10, 20)]];
        } else {
            cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"tablebg_mid.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 20, 10, 20)]];
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"tablebg_mid_highlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 20, 10, 20)]];
        }
    }
    
    cell.backgroundView.alpha = 0.6;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
        return 38;
    else if (indexPath.row == 1 || indexPath.row == self.types.count) 
        return 54;
    else if (indexPath.row == self.types.count + 1)
        return 100;
    else 
        return 44;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end