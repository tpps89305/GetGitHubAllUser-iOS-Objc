//
//  SecondViewController.h
//  Github List
//
//  Created by APP技術部-楊朝富 on 2020/10/7.
//  Copyright © 2020 APP技術部-楊朝富. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageAvator;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelLogin;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UILabel *labelUrl;
@property NSString *login; // Selected User's ID
@end

NS_ASSUME_NONNULL_END
