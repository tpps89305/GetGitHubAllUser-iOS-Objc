//
//  GithubAPIHandler.h
//  Github List
//
//  Created by APP技術部-楊朝富 on 2020/10/20.
//  Copyright © 2020 APP技術部-楊朝富. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GithubUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface GithubAPIHandler : NSObject

- (void) getUserData:(void(^)(NSMutableArray *))block;
- (void) getUserDataWithLoginID:(NSString *)login onSuccess:(void(^)(GithubUser *))block;

@end

NS_ASSUME_NONNULL_END
