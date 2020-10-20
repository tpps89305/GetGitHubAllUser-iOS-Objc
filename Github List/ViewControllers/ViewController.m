//
//  ViewController.m
//  Github List
//
//  Created by APP技術部-楊朝富 on 2020/10/6.
//  Copyright © 2020 APP技術部-楊朝富. All rights reserved.
//

#import "ViewController.h"
#import "GithubUser.h"
#import "GithubUserCell.h"
#import "SecondViewController.h"
#import "GithubAPIHandler.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableArray<GithubUser *> *githubUsers;

- (void)viewDidLoad {
    [super viewDidLoad];
    GithubAPIHandler *handler = [[GithubAPIHandler alloc] init];
    [handler getUserData:^(NSMutableArray * block) {
        githubUsers = block;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Get number of list
    return [githubUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Show data in each row
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    GithubUserCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[GithubUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.label.text = [githubUsers objectAtIndex:indexPath.row].login;
    // Download and show image.
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        // Download image in background thread.
        NSData *image = [NSData dataWithContentsOfURL:[githubUsers objectAtIndex:indexPath.row].avatarUrl];
        dispatch_async(dispatch_get_main_queue(), ^{
            // Load Image in main thread.
            cell.imageView.image = [UIImage imageWithData:image];
        });
    });
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *login = githubUsers[indexPath.row].login;
    [self performSegueWithIdentifier:@"GotoNextPage" sender:login];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GotoNextPage"]) {
        NSLog(@"Prepare to show %@'s data.", sender);
        SecondViewController *secondVC = (SecondViewController *)segue.destinationViewController;
        secondVC.login = sender;
    }
}

@end
