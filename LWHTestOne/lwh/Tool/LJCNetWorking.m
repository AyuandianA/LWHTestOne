//
//  LJCNetWorking.m
//  YiMeiZhiBo
//
//  Created by Aliang Ren on 2018/3/15.
//  Copyright © 2018年 史德萌. All rights reserved.
//

#import "LJCNetWorking.h"
#import <AFNetworking/AFNetworking.h>
//#import "ZMHY.h"
#import "UIImage+Category.h"
#import "NSString+judgement.h"
#import <sys/utsname.h>

static AFHTTPSessionManager *manager = nil;

@implementation LJCNetWorking

+ (AFHTTPSessionManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        
        NSMutableSet * contentTypes = [[NSMutableSet alloc]initWithSet:manager.responseSerializer.acceptableContentTypes];
        
        [contentTypes addObject:@"text/html"];
        
        [contentTypes addObject:@"text/plain"];
        
        manager.responseSerializer.acceptableContentTypes = contentTypes;
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 10;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    });
    
    return manager;
}

+ (void)GET_URL:(NSString *)url params:(NSDictionary *)params dataBlock:(DataBlock)dataBlock {
    
}
+ (void)POST_URL:(NSString *)url params:(NSDictionary *)params dataBlock:(DataBlock)dataBlock {
//
//    NSMutableDictionary *mDic;
//
//    if (!params) {
//
//        mDic = [[NSMutableDictionary alloc]init];
//
//    } else {
//        mDic = [[NSMutableDictionary alloc]initWithDictionary:params];
//    }
//    if (![mDic objectForKey:@"user_id"]) {
//
//        if (Encrypt_Id) {
//            [mDic setValue:Encrypt_Id forKey:@"user_id"];
//        }
//    }
//    // 手机系统版本号
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    // 手机系统
//    NSString * iponeM = [[UIDevice currentDevice] systemName];
//    // 手机型号
//    NSString *phoneModel = [self iphoneType];
//    //版本号
//    NSString *thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//
//    [mDic setValue:Api_Token forKey:Source_Token];
//
//    [mDic setValue:Api_Id forKey:Source_Id];
//
//    [mDic setValue:@"2" forKey:Source_Type];
//
//    [mDic setValue:@"1" forKey:Source_Genre];
//
//    if ([UserMaterialModel shareUser].longitude) {
//        [mDic setValue:[UserMaterialModel shareUser].longitude forKey:@"longitude"];
//    } else {
//        [mDic setValue:@"" forKey:@"longitude"];
//    }
//
//    if ([UserMaterialModel shareUser].latitude) {
//        [mDic setValue:[UserMaterialModel shareUser].latitude forKey:@"latitude"];
//    } else {
//        [mDic setValue:@"" forKey:@"latitude"];
//    }
//
//    if ([UserMaterialModel shareUser].city_name) {
//        [mDic setValue:[UserMaterialModel shareUser].city_name forKey:@"city_name"];
//    } else {
//        [mDic setValue:@"" forKey:@"city_name"];
//    }
//
//    [mDic setValue:thisVersion forKey:Source_Version];
//
//    [mDic setValue:[NSString stringWithFormat:@"%@,%@ %@",phoneModel,iponeM,phoneVersion] forKey:Source_Model];
//
//    [mDic setValue:@"iOS" forKey:Source_System];
//
////    NSLog(@"url == %@  mDic == %@",url,mDic);
//
//    AFHTTPSessionManager *manager = [self sharedManager];
//
//    [manager POST:url parameters:mDic progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        [LJCProgressHUD hiddenHud];
//
//        id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//
////        NSLog(@"url == %@  dic == %@",url,dic);
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            if (dic) {
//
//                if ([dic[@"error"] intValue] == 1) {
//                    dataBlock(dic);
//
//                    if ([url isEqualToString:Add_Friend]) {
//                        // 好友数量变化更新操作
//                        [[UserMaterialModel shareUser] upDataUserInfo];
//                    }
//
//                } else {
//
//                    if ([dic[@"error"] intValue] > 999) {
//                        dataBlock(nil);
//                        [LJCProgressHUD showStatueText:dic[@"errorMsg"]];
//                    } else {
//                        if ([dic[@"error"] intValue] == 999) {
//                            dataBlock(nil);
//                        } else if ([dic[@"error"] intValue] == 998) {
//                            dataBlock(nil);
//                        } else if ([dic[@"error"] intValue] == 995) {
//                            // 未绑定手机号
//                            dataBlock(dic);
//                        } else if ([dic[@"error"] intValue] == 994) {
//                            // 未填写擅长项目
//                            dataBlock(dic);
//                        } else {
//                            dataBlock(nil);
//                        }
//                    }
//
//                }
//
//            } else {
//                dataBlock(nil);
//            }
//
//        });
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////        NSLog(@"失败：code = %ld",error.code);
////        NSLog(@"responseObject = %@",error.userInfo);
//        [LJCProgressHUD hiddenHud];
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            dataBlock(nil);
//
//            if (error.code == -1009) {
//
//
//            }
//
//        });
//
//    }];
    
}
#pragma - mark 上传图片&视频
+ (void)UpImageWithUrl:(NSString *)url params:(NSDictionary *)params data:(NSData *)imgData fileName:(NSString *)name progress:(ProgressBlock)progres dataBlock:(DataBlock)dataBlock {
    
//    NSMutableDictionary *mDic;
//    
//    if (!params) {
//        
//        mDic = [[NSMutableDictionary alloc]init];
//        
//    } else {
//        
//        mDic = [[NSMutableDictionary alloc]initWithDictionary:params];
//    }
//    
//    if (![mDic objectForKey:@"user_id"]) {
//        
//        if (Encrypt_Id) {
//            [mDic setValue:Encrypt_Id forKey:@"user_id"];
//        }
//    }
//    
//    NSString *thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    
//    [mDic setValue:thisVersion forKey:@"version"];
//    
//    // 手机系统版本号
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    // 手机系统
//    NSString * iponeM = [[UIDevice currentDevice] systemName];
//    // 手机型号
//    NSString *phoneModel = [self iphoneType];
//    
//    [mDic setValue:Api_Token forKey:Source_Token];
//    
//    [mDic setValue:Api_Id forKey:Source_Id];
//    
//    [mDic setValue:@"2" forKey:Source_Type];
//    
//    [mDic setValue:@"1" forKey:Source_Genre];
//    
//    [mDic setValue:thisVersion forKey:Source_Version];
//    
//    [mDic setValue:[NSString stringWithFormat:@"%@,%@ %@",phoneModel,iponeM,phoneVersion] forKey:Source_Model];
//    
//    [mDic setValue:@"iOS" forKey:Source_System];
//    
//    AFHTTPSessionManager *manager = [self sharedManager];
//    
//    [manager POST:url parameters:mDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSString *type = [name isEqualToString:@"upload-video"] ? @"video/mp4" : @"image/png";
//        [formData appendPartWithFileData:imgData name:name fileName:@"images" mimeType:type];
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            progres(1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
//            
//        });
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            dataBlock(dic);
//            
//        });
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        [LJCProgressHUD hiddenHud];
//        
//        [LJCProgressHUD showStatueText:@"上传失败，请重试"];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            dataBlock(nil);
//            
//        });
//    }];
//    
//}
//#pragma - mark 上传文件
//+ (void)UpLoadFile:(NSString *)url params:(NSDictionary *)params data:(NSData *)fileData fileName:(NSString *)name progress:(ProgressBlock)progres dataBlock:(DataBlock)dataBlock {
//    
//    NSMutableDictionary *mDic;
//    
//    if (!params) {
//        
//        mDic = [[NSMutableDictionary alloc]init];
//        
//    } else {
//        
//        mDic = [[NSMutableDictionary alloc]initWithDictionary:params];
//    }
//    
//    if (![mDic objectForKey:@"user_id"]) {
//        
//        if (Encrypt_Id) {
//            [mDic setValue:Encrypt_Id forKey:@"user_id"];
//        }
//    }
//
//    NSString *thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    
//    [mDic setValue:thisVersion forKey:@"version"];
//    
//    // 手机系统版本号
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    // 手机系统
//    NSString * iponeM = [[UIDevice currentDevice] systemName];
//    // 手机型号
//    NSString *phoneModel = [self iphoneType];
//    
//    [mDic setValue:Api_Token forKey:Source_Token];
//    
//    [mDic setValue:Api_Id forKey:Source_Id];
//    
//    [mDic setValue:@"2" forKey:Source_Type];
//    
//    [mDic setValue:@"1" forKey:Source_Genre];
//    
//    [mDic setValue:thisVersion forKey:Source_Version];
//    
//    [mDic setValue:[NSString stringWithFormat:@"%@,%@ %@",phoneModel,iponeM,phoneVersion] forKey:Source_Model];
//    
//    [mDic setValue:@"iOS" forKey:Source_System];
//    
//    AFHTTPSessionManager *manager = [self sharedManager];
//    
//    [manager POST:url parameters:mDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSString *type = [name isEqualToString:@"imgfile"] ? @"image/png" : [name isEqualToString:@"videofile"] ? @"video/mp4" : @"wav";
//        [formData appendPartWithFileData:fileData name:name fileName:@"xxxx" mimeType:type];
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            progres(1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
//            
//        });
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            dataBlock(dic);
//            
//        });
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        [LJCProgressHUD hiddenHud];
//        
//        [LJCProgressHUD showStatueText:@"上传失败，请重试"];
//        
////        NSLog(@"失败：code = %ld",error.code);
//        
////        NSLog(@"responseObject = %@",error.userInfo);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            dataBlock(nil);
//            
//        });
//    }];
    
}
#pragma - mark 多图上传
+ (void)UpImageWithUrl:(NSString *)url params:(NSDictionary *)params withImageArray:(NSMutableArray *)images progress:(ProgressBlock)progres dataBlock:(DataBlock)dataBlock {
    
//    NSMutableDictionary *mDic;
//    
//    if (!params) {
//        
//        mDic = [[NSMutableDictionary alloc]init];
//        
//    } else {
//        
//        mDic = [[NSMutableDictionary alloc]initWithDictionary:params];
//    }
//    
//    if (![mDic objectForKey:@"user_id"]) {
//        
//        if (Encrypt_Id) {
//            [mDic setValue:Encrypt_Id forKey:@"user_id"];
//        }
//    }
//    
//    NSString *thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    
//    [mDic setValue:thisVersion forKey:@"version"];
//    
//    // 手机系统版本号
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    // 手机系统
//    NSString * iponeM = [[UIDevice currentDevice] systemName];
//    // 手机型号
//    NSString *phoneModel = [self iphoneType];
//    
//    [mDic setValue:Api_Token forKey:Source_Token];
//    
//    [mDic setValue:Api_Id forKey:Source_Id];
//    
//    [mDic setValue:@"2" forKey:Source_Type];
//    
//    [mDic setValue:@"1" forKey:Source_Genre];
//    
//    [mDic setValue:thisVersion forKey:Source_Version];
//    
//    [mDic setValue:[NSString stringWithFormat:@"%@,%@ %@",phoneModel,iponeM,phoneVersion] forKey:Source_Model];
//    
//    [mDic setValue:@"iOS" forKey:Source_System];
//    
//    AFHTTPSessionManager *manager = [self sharedManager];
//    
//    [manager POST:url parameters:mDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        for (UIImage *image in images) {
//            
////            NSData *imageData = [UIImage reSizeImageData:image maxImageSize:800 maxSizeWithKB:40];
//            
//            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"file_img[]" fileName:@"images" mimeType:@"image/png"];
//            
//        }
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            progres(1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
//            
//        });
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            dataBlock(dic);
//            
//        });
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        [LJCProgressHUD hiddenHud];
//        
//        [LJCProgressHUD showStatueText:@"图片上传失败，请重试"];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            dataBlock(nil);
//            
//        });
//    }];
    
}

+ (NSString *)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone11,8"]) return@"iPhone XR";
    
    if([platform isEqualToString:@"iPhone11,2"]) return@"iPhone XS";
    
    if([platform isEqualToString:@"iPhone11,6"]) return@"iPhone XS Max";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}

@end
