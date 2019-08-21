//
//  LJCNetWorking.h
//  YiMeiZhiBo
//
//  Created by Aliang Ren on 2018/3/15.
//  Copyright © 2018年 史德萌. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
typedef void (^DataBlock)(id data);
typedef void (^ProgressBlock)(double progress);

@interface LJCNetWorking : NSObject

// GET
+ (void)GET_URL:(NSString *)url params:(NSDictionary *)params dataBlock:(DataBlock)dataBlock;
// POST
+ (void)POST_URL:(NSString *)url params:(NSDictionary *)params dataBlock:(DataBlock)dataBlock;
// 上传图片
+ (void)UpImageWithUrl:(NSString *)url params:(NSDictionary *)params data:(NSData *)imgData fileName:(NSString *)name progress:(ProgressBlock)progres dataBlock:(DataBlock)dataBlock;
// 多图上传
+ (void)UpImageWithUrl:(NSString *)url params:(NSDictionary *)params withImageArray:(NSMutableArray *)images progress:(ProgressBlock)progres dataBlock:(DataBlock)dataBlock;
// 上传文件
+ (void)UpLoadFile:(NSString *)url params:(NSDictionary *)params data:(NSData *)fileData fileName:(NSString *)name progress:(ProgressBlock)progres dataBlock:(DataBlock)dataBlock;

@end
