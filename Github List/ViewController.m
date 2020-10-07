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

@interface ViewController ()

@end

@implementation ViewController

NSMutableArray<GithubUser *> *githubUsers;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Download JSON from Github API
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError;
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Failed to serialize into JSON; %@", jsonError);
        } else {
            // Parse JSON to Object
            githubUsers = NSMutableArray.new;
            for (NSDictionary *courseDict in json) {
                GithubUser *githubuser = GithubUser.new;
                githubuser.id = courseDict[@"id"];
                githubuser.login = courseDict[@"login"];
                githubuser.avatarUrl = [NSURL URLWithString:courseDict[@"avatar_url"]];
                [githubUsers addObject:githubuser];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    [dataTask resume];
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
    NSData *image = [NSData dataWithContentsOfURL:[githubUsers objectAtIndex:indexPath.row].avatarUrl];
    cell.imageView.image = [UIImage imageWithData:image];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSNumber *aaaa = [NSNumber numberWithInteger:indexPath.row];
    [self performSegueWithIdentifier:@"GotoNextPage" sender:aaaa];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GotoNextPage"]) {
        NSLog(@"Ready to show data from row %@", sender);
        SecondViewController *secondVC = (SecondViewController *)segue.destinationViewController;
        
    }
}

@end
