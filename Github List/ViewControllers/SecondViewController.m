//
//  SecondViewController.m
//  Github List
//
//  Created by APP技術部-楊朝富 on 2020/10/7.
//  Copyright © 2020 APP技術部-楊朝富. All rights reserved.
//

#import "SecondViewController.h"
#import "GithubUser.h"
#import "GithubAPIHandler.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Ready to show %@'s data.", _login);
    GithubAPIHandler *handler = [[GithubAPIHandler alloc] init];
    [handler getUserDataWithLoginID:_login onSuccess:^(GithubUser * githubuser) {
        if (![githubuser.avatarUrl isEqual:[NSNull null]]) {
            NSData *image = [NSData dataWithContentsOfURL:githubuser.avatarUrl];
            self.imageAvator.image = [UIImage imageWithData:image];
        }
        if (![githubuser.name isEqual:[NSNull null]])
            self.labelName.text = githubuser.name;
        else
            self.labelName.text = githubuser.login;
        if (![githubuser.login isEqual:[NSNull null]])
            self.labelLogin.text = githubuser.login;
        if (![githubuser.location isEqual:[NSNull null]])
            self.labelLocation.text = githubuser.location;
        if (![githubuser.url isEqual:[NSNull null]])
            self.labelUrl.text = githubuser.url;
    }];
}

- (IBAction)dismissPage:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
