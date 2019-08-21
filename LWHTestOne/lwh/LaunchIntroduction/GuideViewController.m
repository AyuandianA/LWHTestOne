//
//  GuideViewController.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/6.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import "GuideViewController.h"
#import "LaunchIntroductionView.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[LaunchIntroductionView sharedWithImages:@[@"guide_image.jpg",@"guide_image1.jpg"]]];
    
}

@end
