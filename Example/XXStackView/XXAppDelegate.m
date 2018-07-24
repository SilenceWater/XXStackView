//
//  XXAppDelegate.m
//  XXStackView
//
//  Created by shichang.wang on 07/24/2018.
//  Copyright (c) 2018 shichang.wang. All rights reserved.
//

#import "XXAppDelegate.h"
#import "XXViewController.h"

@implementation XXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setupRootViewController];
    

    return YES;
}

- (void)setupRootViewController {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    XXViewController *vc = [[XXViewController alloc]init];
    UINavigationController *rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];

}


@end
