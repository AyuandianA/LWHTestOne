//
//  UserMaterialModel.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/7/2.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "UserMaterialModel.h"
#import "CZSocketManager.h"
//#import "StorageManager.h"

static UserMaterialModel *_user = nil;
static dispatch_once_t onceToken;

@implementation UserMaterialModel

+ (instancetype)shareUser {
    
    dispatch_once(&onceToken, ^{
        
        if (!_user) {
            _user = [[UserMaterialModel alloc] init];
        }
        
    });
    
    return _user;
}

- (instancetype)init {
    
    if ([super init]) {
        
        [self cleanParams];
        
        if ([StorageManager objForKey:@"user_material_data"]) {
            
            NSDictionary *dic = [StorageManager objForKey:@"user_material_data"];
            
            if (![dic[@"bespeak"] isKindOfClass:[NSNull class]]) {
                
                [self modelSetWithDictionary:dic[@"info"]];
                
                [self setOrderNumber:dic];
              
            }
            
            if (![dic[@"server"] isKindOfClass:[NSNull class]]) {
                [self setServiceInfo:dic];
            }
         
        }
      
    }
    
    return self;
    
}

- (void)upDataUserInfo {
    
//    if (!Encrypt_Id) {
//
//        return;
//    }
//
//    [LJCNetWorking POST_URL:User_Material params:nil dataBlock:^(id data) {
////        NSLog(@"----%@",data);
//        if (data) {
//
//            [self modelSetWithDictionary:data[@"data"][@"info"]];
//
//            [self setOrderNumber:data[@"data"]];
//
//            [self setServiceInfo:data[@"data"]];
//
//            [StorageManager setObj:data[@"data"] forKey:@"user_material_data"];
//
//        }
//
//    }];
    
}
- (void)setOrderNumber:(NSDictionary *)dic {
    
    self.drawback = [NSString stringWithFormat:@"%@",dic[@"bespeak"][@"drawback"]];
    
    self.need_case = [NSString stringWithFormat:@"%@",dic[@"bespeak"][@"need_case"]];
    
    self.need_comment = [NSString stringWithFormat:@"%@",dic[@"bespeak"][@"need_comment"]];
    
    self.need_pay = [NSString stringWithFormat:@"%@",dic[@"bespeak"][@"need_pay"]];
    
    self.bespoke = [NSString stringWithFormat:@"%@",dic[@"bespoke"]];
    
}
- (void)setServiceInfo:(NSDictionary *)dic {
    
    self.server_name = dic[@"server"][@"server_name"];
    self.server_phone = [NSString stringWithFormat:@"%@",dic[@"server"][@"server_phone"]];
    self.server_user_id = [NSString stringWithFormat:@"%@",dic[@"server"][@"server_user_id"]];
    
}

- (void)cleanLoginInfo {
    
    [LJCProgressHUD showAnnulusHud];
    
//    [LJCNetWorking POST_URL:Upush_Device_Stats params:@{@"device_stats":@"2"} dataBlock:^(id data) {
//
//        if (data) {
//
//            [StorageManager removeKey:@"encrypt_userid"];
//            [StorageManager removeKey:@"user_id"];
//            [StorageManager removeKey:@"telphone"];
//            [StorageManager removeKey:@"user_material_data"];
//            [StorageManager removeKey:Badge_Number];
//            [StorageManager removeKey:Chat_Note_Cache];
//            [StorageManager removeKey:Conversation_List_Cache];
//
//            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//            // 断开 socket
//            [[CZSocketManager shareSocket] breakSocket];
//
//            [self cleanParams];
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:Reload_Data_Source object:nil];
//
//        }
    
//    }];
    
}
// 清除用户数据
- (void)cleanParams {
    
    self.blog_num = @"";
    self.card_num = @"";
    self.case_num = @"";
    self.fans_num = @"";
    self.friends_num = @"";
    self.head_img_url = @"";
    self.photo_num = @"";
    self.position = @"";
    self.star_level = @"";
    self.star_score = @"";
    self.longitude = @"";
    self.latitude = @"";
    self.city_name = @"";
    self.username = @"";
    self.is_doctor = @"";
    self.role = @"";
    self.sex = @"";
    self.dingjin_price = @"";
    self.signature = @"";
    self.telphone = @"";
    self.drawback = @""; //
    self.need_case = @""; //
    self.project_name = @"";
    self.need_comment = @"";
    self.month = @"";
    self.need_pay = @""; //
    self.orderTime = @"";
    self.bespoke = @""; //
    self.year = @"";
    self.orderCurrentTime = @"";
    self.day = @"";
    self.orderType = @"";
    self.orderID = @"";
    self.server_name = @"";
    self.server_phone = @"";
    self.server_user_id = @"";
    
}

@end
