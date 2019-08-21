//
//  ShareView.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/7/19.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "ShareView.h"
#import "UIImage+Category.h"
#import "WXApi.h"

static ShareView *_shareView = nil;
static dispatch_once_t onceToken;

@interface ShareView ()
// 分享
@property(nonatomic,strong)UIView *shareView;

@end

@implementation ShareView

+ (instancetype)shareViewManager {
    
    dispatch_once(&onceToken, ^{
        
        if (!_shareView) {
            _shareView = [[ShareView alloc] init];
        }
        
    });
    
    return _shareView;
    
}

- (instancetype)init {
    
    if ([super init]) {
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelBtnAction)];
        [self addGestureRecognizer:tap];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        [self addSubview:self.shareView];
    }
    
    return self;
}

- (UIView *)shareView {
    
    if (!_shareView) {
        
        _shareView = [[UIView alloc]init];
        _shareView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 170+SafeAreaH);
        _shareView.backgroundColor = [UIColor whiteColor];
        
        UIButton  *vxBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        vxBtn.frame =CGRectMake((kScreenWidth-200)/4, 20, 100, 80);
        [vxBtn setImage:BundleTabeImage(@"share_wechat.png") forState:UIControlStateNormal];
        [vxBtn setImage:BundleTabeImage(@"share_wechat.png") forState:UIControlStateSelected];
        vxBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 30, 35, 30);
        vxBtn.tag = 100;
        [vxBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
        //
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 20)];
        title.font = [UIFont systemFontOfSize:TextFont];
        title.textColor = [UIColor lightGrayColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"微信";
        [vxBtn addSubview:title];
        //
        [_shareView addSubview:vxBtn];
       
        
        UIButton  *pyqBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        pyqBtn.frame =CGRectMake((kScreenWidth-200)/4*3+100, 20, 100, 80);
        [pyqBtn setImage:BundleTabeImage(@"pengyouquan_selecte.png") forState:UIControlStateNormal];
        [pyqBtn setImage:BundleTabeImage(@"pengyouquan_selecte.png") forState:UIControlStateSelected];
        pyqBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 30, 35, 30);
        pyqBtn.tag = 110;
        [pyqBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
        //
        UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 20)];
        title1.font = [UIFont systemFontOfSize:TextFont];
        title1.textColor = [UIColor lightGrayColor];
        title1.textAlignment = NSTextAlignmentCenter;
        title1.text = @"朋友圈";
        [pyqBtn addSubview:title1];
        //
        [_shareView addSubview:pyqBtn];
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.frame = CGRectMake(0, 109, kScreenWidth, 1);
        lineLabel.backgroundColor = MainBackColor;
        [self.shareView addSubview:lineLabel];
        
        UIButton  *cancelBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 120, kScreenWidth, 50);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:cancelBtn];
    }
    
    return _shareView;
}

- (void)shareBtn:(UIButton *)btn {
//    NSLog(@"分享");
    if (![WXApi isWXAppInstalled]) {
        
        [LJCProgressHUD showStatueText:@"请先安装微信"];
        
        return;
        
    }
    
    WXMediaMessage * message = [WXMediaMessage message];
    message.title = self.shareParam[@"share_title"];
    message.description = self.shareParam[@"share_desc"];
    
    UIImage *oImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareParam[@"share_icon"]]]];
    
    UIImage *img = [UIImage imageWithData:[UIImage reSizeImageData:oImg maxImageSize:200 maxSizeWithKB:20]];
    
    [message setThumbImage:img];

    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = self.shareParam[@"share_url"];
    message.mediaObject = webObj;
   
    SendMessageToWXReq * req1 = [[SendMessageToWXReq alloc]init];
    req1.bText = NO;
    req1.message = message;
    // 类型： 朋友圈(WXSceneTimeline)、好友会话(WXSceneSession)、收藏(WXSceneFavorite)
    if (btn.tag == 100) {
        req1.scene = WXSceneSession;
        self.share_type = @"1";
    } else {
        req1.scene = WXSceneTimeline;
        self.share_type = @"2";
    }
    
    [WXApi sendReq:req1];
    
}
// 图片压缩、裁剪
- (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}
- (void)cancelBtnAction {
    
    [UIView animateWithDuration:.3 animations:^{
        self.shareView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)showShareView {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:.3 animations:^{
        self.shareView.transform = CGAffineTransformMakeTranslation(0, -(170+SafeAreaH));
    }];
}

- (void)hiddenShareView {
    [self cancelBtnAction];
}

- (void)shareSucc {
    
//    [LJCNetWorking POST_URL:Share_Succ params:@{@"typeid":self.shareParam[@"typeid"],@"type":self.shareParam[@"type"],@"source":self.share_type} dataBlock:^(id data) {
//       
//        [self hiddenShareView];
//      
//    }];
    
}

@end
