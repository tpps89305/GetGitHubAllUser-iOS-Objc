//
//  SecondViewController.m
//  Github List
//
//  Created by APP技術部-楊朝富 on 2020/10/7.
//  Copyright © 2020 APP技術部-楊朝富. All rights reserved.
//

#import "SecondViewController.h"
#import "GithubUser.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Ready to show %@'s data.", _login);
    NSString *urlStr = [NSString stringWithFormat:@"https://api.github.com/users/%@", _login];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError;
        NSDictionary *currentUser = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Failed to serialize into JSON; %@", jsonError);
        } else {
            GithubUser *githubuser = GithubUser.new;
            githubuser.id = currentUser[@"id"];
            githubuser.login = currentUser[@"login"];
            githubuser.avatarUrl = [NSURL URLWithString:currentUser[@"avatar_url"]];
            githubuser.name = currentUser[@"name"];
            githubuser.location = currentUser[@"location"];
            githubuser.url = currentUser[@"url"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (![githubuser.avatarUrl isEqual:[NSNull null]]) {
                    NSData *image = [NSData dataWithContentsOfURL:githubuser.avatarUrl];
                    self->_imageAvator.image = [UIImage imageWithData:image];
                }
                if (![githubuser.name isEqual:[NSNull null]])
                    self->_labelName.text = githubuser.name;
                else
                    self->_labelName.text = githubuser.login;
                if (![githubuser.login isEqual:[NSNull null]])
                    self->_labelLogin.text = githubuser.login;
                if (![githubuser.location isEqual:[NSNull null]])
                    self->_labelLocation.text = githubuser.location;
                if (![githubuser.url isEqual:[NSNull null]])
                    self->_labelUrl.text = githubuser.url;
            });
        }
    }];
    [dataTask resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
