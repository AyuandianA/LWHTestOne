//
//  CXCameraManager.m
//  YiMeiZhiBo
//
//  Created by 史德萌 on 2017/2/23.
//  Copyright © 2017年 史德萌. All rights reserved.
//

#import "CXCameraManager.h"
#import <MobileCoreServices/MobileCoreServices.h>

static CXCameraManager *camera = nil;

@interface CXCameraManager ()<UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,LJCActionSheetDelegate> {
    
    BOOL _isHave;
    
}

@end

@implementation CXCameraManager {
    
    UIImagePickerController *pickerController;
    
}

+ (CXCameraManager *)shareManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        camera = [[CXCameraManager alloc]init];
        
    });
    
    return camera;
}
- (void)showSystemPhotoAlbum:(UIViewController *)faterVC delegate:(id<CXCameraManagerDelegate>)delegate haveVideo:(BOOL)isHave {
    
    camera.CXCameraManagerDelegate = delegate;
    
    _isHave = isHave;
    
    self.viewContriller = faterVC;
    
    pickerController= [[UIImagePickerController alloc] init];
    
    pickerController.delegate = self;
    
    pickerController.navigationBar.translucent = NO;//去除毛玻璃效果
    
    pickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    NSArray *title;
    
    if (_isHave) {
        
        title = @[@"相册",@"拍摄"];
        
    } else {
        
        title = @[@"相册",@"拍照"];
        
    }
    
    LJCActionSheet *sheet = [LJCActionSheet actionSheetWithTitle:@"提示" confirms:title cancel:@"取消" style:LJCActionSheetStyleDefault];
    sheet.delegate = self;
    
    [sheet showInView:self.viewContriller.view.window];
    
}

- (void)clickAction:(LJCActionSheet *)actionSheet atIndex:(NSUInteger)index sheetTitle:(NSString *)title {
    
    if (index == 0) {
        
        [self fromPhotos];
        
    } else if (index == 1) {
        
        [self createPhotoView];
        
    }
    
}

- (void)fromPhotos{
    
    if (_isHave) {
        pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; // 相簿
        pickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    } else {
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; // 相册
        pickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    }
    
    pickerController.navigationBar.translucent = NO;//去除毛玻璃效果
    [_viewContriller presentViewController:pickerController animated:YES completion:nil];
}
- (void)createPhotoView{
    // ** 设置相机模式
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.videoMaximumDuration = 600;
    pickerController.navigationBar.translucent = NO;//去除毛玻璃效果
    if (_isHave) {
        pickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    } else {
        pickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    }
    //视频质量
    pickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    [_viewContriller presentViewController:pickerController animated:YES completion:nil];

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"该设备没有照相机"
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
    }

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
   
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

        if (self.CXCameraManagerDelegate && [self.CXCameraManagerDelegate respondsToSelector:@selector(selectPhotoAlbunResource:resourceType:)]) {
            [self.CXCameraManagerDelegate selectPhotoAlbunResource:image resourceType:1];
        }
    }else{
        //如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];
        if (self.CXCameraManagerDelegate && [self.CXCameraManagerDelegate respondsToSelector:@selector(selectPhotoAlbunResource:resourceType:)]) {
            [self.CXCameraManagerDelegate selectPhotoAlbunResource:url resourceType:2];
        }

    }
    
    [_viewContriller dismissViewControllerAnimated:YES completion:nil];
}

@end
