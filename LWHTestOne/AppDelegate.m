//
//  AppDelegate.m
//  LWHTestOne
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import "AppDelegate.h"

#import "BaseTabbarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    #if DEBUG
        [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    #endif
    BaseTabbarController *tab = [[BaseTabbarController alloc]init];
    
    self.window.rootViewController = tab;
//    [self fontNames];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
