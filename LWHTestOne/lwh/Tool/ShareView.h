//
//  ShareView.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/7/19.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareView : UIView

+ (instancetype)shareViewManager;

@property(nonatomic,copy) NSString *share_type; // 1 好友  2 朋友圈

@property(nonatomic,strong) NSDictionary *shareParam; // 参数

- (void)showShareView; //

- (void)hiddenShareView; //

- (void)shareSucc; // 分享成功

@end

NS_ASSUME_NONNULL_END
