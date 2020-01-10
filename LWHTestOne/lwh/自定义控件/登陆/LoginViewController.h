//
//  LoginViewController.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/18.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : BaseViewController
// 1 登录  2 绑定手机号 3 修改手机号
@property(assign,nonatomic) int type;

@property(copy,nonatomic) NSString *userInfo;


@end

NS_ASSUME_NONNULL_END
