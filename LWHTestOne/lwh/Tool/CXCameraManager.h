//
//  CXCameraManager.h
//  YiMeiZhiBo
//
//  Created by 史德萌 on 2017/2/23.
//  Copyright © 2017年 史德萌. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CXCameraManagerDelegate<NSObject>

@optional
// type 1图片   2视频
- (void)selectPhotoAlbunResource:(id)resource resourceType:(NSInteger)type;

@end

@interface CXCameraManager : NSObject 

@property(nonatomic,weak)id <CXCameraManagerDelegate> CXCameraManagerDelegate;

@property(nonatomic,strong) UIViewController *viewContriller;

+ (CXCameraManager *)shareManager;
//
- (void)showSystemPhotoAlbum:(UIViewController *)faterVC delegate:(id<CXCameraManagerDelegate>)delegate haveVideo:(BOOL)isHave;
@end
