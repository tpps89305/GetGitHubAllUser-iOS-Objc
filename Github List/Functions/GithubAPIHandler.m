//
//  GithubAPIHandler.m
//  Github List
//
//  Created by APP技術部-楊朝富 on 2020/10/20.
//  Copyright © 2020 APP技術部-楊朝富. All rights reserved.
//

#import "GithubAPIHandler.h"
#import "GithubUser.h"

/// Github API Handler
@implementation GithubAPIHandler

/// Get Github users List. Block will return to main thread.
/// @param block Data from Github API. Return nil(null) if error occurred.
- (void) getUserData:(void (^)(NSMutableArray * _Nullable))block {
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray<GithubUser *> *githubUsers = nil;
        NSError *jsonError;
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Failed to serialize into JSON: %@", jsonError);
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
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(githubUsers);
        });
    }];
    [dataTask resume];
}

/// Get Github user's detail info, with login ID. Block will return to main thread.
/// @param login Github user's login ID
/// @param block Data from Github API. Return nil(null) if error occurred.
- (void) getUserDataWithLoginID:(NSString *)login onSuccess:(void (^)(GithubUser * _Nullable))block {
    NSString *urlStr = [NSString stringWithFormat:@"https://api.github.com/users/%@", login];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        GithubUser *githubuser = nil;
        NSError *jsonError;
        NSDictionary *currentUser = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Failed to serialize into JSON: %@", jsonError);
        } else {
            githubuser = GithubUser.new;
            githubuser.id = currentUser[@"id"];
            githubuser.login = currentUser[@"login"];
            githubuser.avatarUrl = [NSURL URLWithString:currentUser[@"avatar_url"]];
            githubuser.name = currentUser[@"name"];
            githubuser.location = currentUser[@"location"];
            githubuser.url = currentUser[@"url"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(githubuser);
        });
    }];
    [dataTask resume];
}

@end
