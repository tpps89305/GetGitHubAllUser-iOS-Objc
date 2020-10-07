//
//  ViewController.m
//  Github List
//
//  Created by APP技術部-楊朝富 on 2020/10/6.
//  Copyright © 2020 APP技術部-楊朝富. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Download JSON from Github API
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", json);
    }];
    [dataTask resume];
}


@end
