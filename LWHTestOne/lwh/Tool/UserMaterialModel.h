//
//  UserMaterialModel.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/7/2.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserMaterialModel : NSObject
// 用户信息单例
+ (instancetype)shareUser;
// 更新用户信息
- (void)upDataUserInfo;
// 清除用户信息
- (void)cleanLoginInfo;
//
- (void)setOrderNumber:(NSDictionary *)dic;

@property(copy, nonatomic)NSString *blog_num;
@property(copy, nonatomic)NSString *card_num;
@property(copy, nonatomic)NSString *case_num;
@property(copy, nonatomic)NSString *fans_num;
@property(copy, nonatomic)NSString *friends_num;
@property(copy, nonatomic)NSString *head_img_url;
@property(copy, nonatomic)NSString *photo_num;
@property(copy, nonatomic)NSString *position;
@property(copy, nonatomic)NSString *star_level;
@property(copy, nonatomic)NSString *star_score;
@property(copy, nonatomic)NSString *username;
@property(copy, nonatomic)NSString *is_doctor;
//@property(copy, nonatomic)NSString *autograph;
@property(copy, nonatomic)NSString *role;
@property(copy, nonatomic)NSString *sex;
@property(copy, nonatomic)NSString *signature;
@property(copy, nonatomic)NSString *telphone;
@property(copy, nonatomic)NSString *month;
@property(copy, nonatomic)NSString *year;
@property(copy, nonatomic)NSString *day;
@property(copy, nonatomic)NSString *is_upush; // 是否开启通知
@property(copy, nonatomic)NSString *longitude;
@property(copy, nonatomic)NSString *latitude;
@property(copy, nonatomic)NSString *city_name;

@property(copy, nonatomic)NSString *is_show; // 是否显示
@property(copy, nonatomic)NSString *is_search; // 是否允许被搜索

// 客服
@property(copy, nonatomic)NSString *server_name;
@property(copy, nonatomic)NSString *server_phone;
@property(copy, nonatomic)NSString *server_user_id;

@property(copy, nonatomic)NSString *drawback; // 退款 数量
@property(copy, nonatomic)NSString *need_case; // 待写日记 数量
@property(copy, nonatomic)NSString *need_comment; // 待评价 数量
@property(copy, nonatomic)NSString *need_pay; // 待付款 数量

@property(copy, nonatomic)NSString *bespoke; // 预约订单数量

//lwh新增字段
@property (nonatomic,copy) NSString *dingjin_price;//定金
@property (nonatomic,copy) NSString *project_name;//项目名称
@property(copy, nonatomic)NSString *orderTime;
@property(copy, nonatomic)NSString *orderCurrentTime;
@property(copy, nonatomic)NSString *orderType;
@property(copy, nonatomic)NSString *orderID;

@end

NS_ASSUME_NONNULL_END
