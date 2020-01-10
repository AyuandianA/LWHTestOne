//
//  OrderListModel.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/25.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListModel : NSObject

@property(nonatomic,copy) NSString * add_time;
@property(nonatomic,copy) NSString * bespeak_time;
@property(nonatomic,copy) NSString * bespoke_id;
@property(nonatomic,copy) NSString * complete_time;
@property(nonatomic,copy) NSString * confirm_time;
@property(nonatomic,copy) NSString * cost;
@property(nonatomic,copy) NSString * customer_id;
@property(nonatomic,copy) NSString * deposit;
@property(nonatomic,copy) NSString * doctor_id;
@property(nonatomic,copy) NSString * doctor_name;
@property(nonatomic,copy) NSString * doctor_position;
@property(nonatomic,copy) NSString * enter_id;
@property(nonatomic,copy) NSString * goods_id;
@property(nonatomic,copy) NSString * dataId;
@property(nonatomic,copy) NSString * is_case;
@property(nonatomic,copy) NSString * is_comment;
@property(nonatomic,copy) NSString * is_paied;
@property(nonatomic,copy) NSString * is_show;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * order_sn;
@property(nonatomic,copy) NSString * organization_id;
@property(nonatomic,copy) NSString * paylog_id;
@property(nonatomic,copy) NSString * phone_number;
@property(nonatomic,copy) NSString * product_id;
@property(nonatomic,copy) NSString * project_id;
@property(nonatomic,copy) NSString * project_img;
@property(nonatomic,copy) NSString * project_name;
@property(nonatomic,copy) NSString * question;
@property(nonatomic,copy) NSString * refund_status;
@property(nonatomic,copy) NSString * share_id;
@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * status_name;
@property(nonatomic,copy) NSString * total_money;
@property(nonatomic,copy) NSString * tuan_id;
@property(nonatomic,copy) NSString * user_id;
@property(nonatomic,copy) NSString * yu_yue_date;
//lwh添加字段
@property(nonatomic,copy) NSString * yuyue_date;

@end

NS_ASSUME_NONNULL_END
