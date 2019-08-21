//
//  CZSocketManager.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/7/2.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CZSocketManagerDelegate <NSObject>

@optional
// 收到一条消息数据
- (void)didReceiveMessageData:(NSDictionary *)messageDic;
// 收到一条动态数据
- (void)didReceiveDynamicData:(NSDictionary *)dynamicData;

@end

@interface CZSocketManager : NSObject

+ (instancetype)shareSocket;

@property(weak, nonatomic) id <CZSocketManagerDelegate> delegate;

@property(assign, nonatomic)BOOL isConnect; // socket是否处于连接状态

- (void)sendDataDic:(NSDictionary *)dic; // 发送数据

- (void)connectSocket; // 连接

- (void)breakSocket; // 断开

- (void)repetitionConnectSocket; // 重连

@end

NS_ASSUME_NONNULL_END
