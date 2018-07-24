//
//  XXAppDelegate.m
//  XXStackView
//
//  Created by shichang.wang on 07/24/2018.
//  Copyright (c) 2018 shichang.wang. All rights reserved.
//

#import "XXAppDelegate.h"
#import <JPush/JPUSHService.h>
#import <WechatOpenSDK/WXApi.h>

#import <SAModuleService/SAModuleService.h>
#import <SAConfig/SAConfig.h>
#import <SAFoundation/SAFoundation.h>
#import <SAKit/SAKit.h>
#import <SAKit/SAViewControllerIntercepter.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import <IQKeyboardManager/IQKeyboardManager.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <SAGlobal/SAGlobalController.h>
#import <SAGlobal/SAUserObject.h>
#import <SADataCollection/SANaturalDataCollectionService.h>

#define kRSA_PublicKey  @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOTJ/mAHAoicU5zfrdHOwltud31eiuW6FS11hvoaeOPtJDtWHMzPANOSbk4UlqojeisbCYw6cLD19Tx3NNfKOt13mtBtuyDNnP7sCcPtLBB8Q8cRgf6AKYg4WN2WNvKuijRbNrLlLhb23fk4WgVNg0xdmZmO+wFMJbU0x+JCankQIDAQAB"

@implementation XXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    [kRSA_PublicKey writePublicKey];
    
    [[SAAppConfig shareInstance] sa_setupTargetType:SATargetTypeAppStore environmentType:SAEnvironmentTypeCIT2];
    
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:nil];
    [JPUSHService setupWithOption:launchOptions
                           appKey:@"8a3d910b13be8bfbd9a0cf23"
                          channel:nil
                 apsForProduction:NO];
    //    [JPUSHService setLogOFF];
    [self setupRootViewController];
    
     [SANaturalDataCollectionService startNaturalDataCollectionServiceWithDebugEnable:YES];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    }
    //配置打印dealloclog
     [SAViewControllerIntercepter enableVCDeallocLog];
    
    [[SAModuleManager sharedInstance] trigger_applicationDidFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)setupRootViewController {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController <SALoginServiceProtocol>*loginController = [SAServiceManager createServiceWithProtocol:@protocol(SALoginServiceProtocol)];
    
    
    __weak typeof(loginController)weakLoginVC = loginController;
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
       
        [weakLoginVC sa_setupJPushRegisterID:registrationID];
    }];
    
    UIViewController *rootViewController = nil;
    if (loginController && ! [SAUserObject sa_isUserLogin]) {
        rootViewController = [[SANavigationController alloc] initWithRootViewController:loginController];
    }else {
        id <SAHomeProtocol>homeObject = [SAServiceManager createServiceWithProtocol:@protocol(SAHomeProtocol)];
        rootViewController = [homeObject setupHomeViewController];
    }
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sa_loginSuccessNotification:) name:SALoginModuleLoginDidSucceedNotification object:nil];
}

- (void)sa_loginSuccessNotification:(NSNotification *)notification {
    id <SAHomeProtocol>homeObject = [SAServiceManager createServiceWithProtocol:@protocol(SAHomeProtocol)];
    UIViewController *rootViewController = [homeObject setupHomeViewController];
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:rootViewController.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        self.window.rootViewController = rootViewController;
                    }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //注册deviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

@end
