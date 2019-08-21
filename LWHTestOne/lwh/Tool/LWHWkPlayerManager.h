//
//  LWHWkPlayerManager.h
//  ChengXianApp
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWHWkPlayerManager : NSObject

+ (instancetype)sharePlayer;
//设置url
-(void)setUpUrl:(NSString *)url andPath:(NSIndexPath *)path andSuperView:(UIView *)superView;
//移除播放器
-(BOOL)releaseWMPlayer;
//播放器是否为nil
-(BOOL)isPlaying;
@end

NS_ASSUME_NONNULL_END
