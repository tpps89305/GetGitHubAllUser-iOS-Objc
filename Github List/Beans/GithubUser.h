//
//  GithubUser.h
//  Github List
//
//  Created by APP技術部-楊朝富 on 2020/10/7.
//  Copyright © 2020 APP技術部-楊朝富. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GithubUser : NSObject
@property NSNumber *id;
@property NSString *login;
@property NSURL *avatarUrl;
@property NSString *name;
@property NSString *location;
@property NSString *url;
@end

NS_ASSUME_NONNULL_END
