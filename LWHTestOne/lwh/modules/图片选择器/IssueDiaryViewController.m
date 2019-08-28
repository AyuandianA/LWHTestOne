//
//  IssueDiaryViewController.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/20.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "IssueDiaryViewController.h"
#import "OrderListModel.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+Category.h"
#import "TZImagePickerController.h"
#import "CustomerTextView.h"
#import "LxGridViewFlowLayout.h"
#import "TZTestCell.h"
#import "UIButton+ImageTitleSpacing.h"
#import "IssueDynamicToolBar.h"

#define imvWidth (kScreenWidth-30-40)/4

@interface IssueDiaryViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,LJCActionSheetDelegate,TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    NSString *_videoUrl;
    NSArray *_imgUrl;
}

@property(strong, nonatomic)IssueDynamicToolBar *toolBar;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) CLLocation *location;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) LxGridViewFlowLayout *layout;
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *selectPhotos;
@property(strong, nonatomic) NSMutableArray *selectedAssets;
@property(strong, nonatomic) CustomerTextView *textView;
@property(strong, nonatomic) UILabel *timeLabel;
@property(strong, nonatomic) UIButton *postoperation;
//@property(strong, nonatomic) UIButton *pyqBtn;
//@property(strong, nonatomic) UIButton *qqBtn;
@property(strong, nonatomic) NSMutableArray *selectVideo;

@end

@implementation IssueDiaryViewController

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.videoQuality = UIImagePickerControllerQualityTypeHigh;
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}
- (IssueDynamicToolBar *)toolBar {
    
    if (!_toolBar) {
        _toolBar = [[IssueDynamicToolBar alloc] initWithTextView:self.textView];
        //        _toolBar.delegate = self;
    }
    
    return _toolBar;
    
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviH+StatusHeight, kScreenWidth, kScreenHeight-SafeAreaH-NaviH-StatusHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleGray;
        _tableView.separatorColor = MainBackColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"发布日记";
    
    self.selectPhotos = [[NSMutableArray alloc]init];
    
    self.selectedAssets = [[NSMutableArray alloc]init];
    
    self.selectVideo = [[NSMutableArray alloc]init];
   

    _layout = [[LxGridViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(imvWidth, imvWidth);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    [self.view addSubview:self.tableView];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 270)];
    header.backgroundColor = [UIColor whiteColor];
    
    NSLocale *loca = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM 月 dd 日";
    formatter.locale = loca;
    NSString *dateStr = [formatter stringFromDate:currentDate];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    calendar.locale = loca;
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:currentDate];
    NSString *weekDayStr = [weekdays objectAtIndex:theComponents.weekday];
   
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",dateStr,weekDayStr]];
    str.font = [UIFont systemFontOfSize:TextFont];
    str.color = MainTopColor;
    [str setFont:[UIFont boldSystemFontOfSize:TextFont+2] range:[str.string rangeOfString:dateStr]];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, (kScreenWidth-20)/2-0.5, 50)];
    self.timeLabel.numberOfLines = 2;
    self.timeLabel.attributedText = str;
    [header addSubview:self.timeLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLabel.frame), 15, 1, 40)];
    line.backgroundColor = MainBackColor;
    [header addSubview:line];
   
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    format.locale = loca;
    
    NSDate *date = [format dateFromString:self.model.yu_yue_date];
//    if (self.model.yuyue_date) {
//        date = [format dateFromString:self.model.yuyue_date];
//    }
    
    NSInteger dayNum = [self numberOfDaysWithFromDate:date toDate:currentDate];
    
    NSMutableAttributedString *shStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"术后第 %ld 天",(long)dayNum]];
    shStr.font = [UIFont systemFontOfSize:TextFont];
    shStr.color = [UIColor lightGrayColor];
    [shStr setFont:[UIFont boldSystemFontOfSize:TextFont] range:[shStr.string rangeOfString:[NSString stringWithFormat:@"%ld",(long)dayNum]]];
    [shStr setColor:MainTopColor range:[shStr.string rangeOfString:[NSString stringWithFormat:@"%ld",(long)dayNum]]];
    
    self.postoperation = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.postoperation setTitleColor:MainTopColor forState:UIControlStateNormal];
    [self.postoperation setAttributedTitle:shStr forState:UIControlStateNormal];
    self.postoperation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.postoperation setImage:BundleTabeImage(@"arrow_right.png") forState:UIControlStateNormal];
    self.postoperation.frame = CGRectMake(CGRectGetMaxX(line.frame), 10, (kScreenWidth-20)/2-0.5, 50);
    [self.postoperation addTarget:self action:@selector(postoperationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.postoperation layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleRight imageTitleSpace:8];
    [header addSubview:self.postoperation];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, 10)];
    line1.backgroundColor = MainBackColor;
    [header addSubview:line1];
    
    self.textView = [[CustomerTextView alloc] initWithFrame:CGRectMake(10, 80, kScreenWidth-20, 180)];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = [UIColor darkTextColor];
    self.textView.placeHolder = @"写下变美后此时此刻的感受吧！";
    self.textView.font = [UIFont systemFontOfSize:TextFont];
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.showsHorizontalScrollIndicator = NO;
    
    [header addSubview:self.textView];
    
    self.tableView.tableHeaderView = header;
    
    [self.view addSubview:self.toolBar];
    
}
// fromDate 起始日期  toDate 结束日期   return 相隔天数
- (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:NSCalendarWrapComponents];

    return comp.day;
}

- (void)postoperationAction {
    
    [self.view endEditing:YES];
    [self.toolBar hiddenView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        if (self.selectedAssets.count) {
            
            if (self.selectedAssets.count%4 != 0) {
                
                return imvWidth*ceil(self.selectedAssets.count/4.0) + (ceil(self.selectedAssets.count/4.0)+1)*10;
                
            }
            
            return imvWidth*(ceil(self.selectedAssets.count/4.0)+1) + (ceil(self.selectedAssets.count/4.0)+1+1)*10;
            
        }
        
        return imvWidth+20;
        
    } else if (indexPath.row == 1) {
        
        return 90;
    } 
    
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderTableViewCell"];
        //        cell.contentView.backgroundColor = MainBackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = YES;
        
        if (self.selectedAssets.count) {
            
            if (self.selectedAssets.count%4 != 0) {
                
                self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, imvWidth*ceil(self.selectedAssets.count/4.0) + (ceil(self.selectedAssets.count/4.0)+1)*10);
                
            } else {
                
                self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, imvWidth*(ceil(self.selectedAssets.count/4.0)+1) + (ceil(self.selectedAssets.count/4.0)+1+1)*10);
                
            }
            
        } else {
            
            self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, imvWidth+20);
            
        }
        
        [self.collectionView removeFromSuperview];
        
        [cell.contentView addSubview:self.collectionView];
        
        [self.collectionView reloadData];
        
        return cell;
        
    } else if (indexPath.row == 1) {
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IssueDiaryCell"];
        //        cell.contentView.backgroundColor = MainBackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        OrderInfoView *orderInfo = [[OrderInfoView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 70)];
//        orderInfo.model = self.model;
//        [cell.contentView addSubview:orderInfo];
        
        return cell;
        
    } else {
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IssueDiaryBtn"];
        //        cell.contentView.backgroundColor = MainBackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
        send.titleLabel.font = [UIFont systemFontOfSize:TextFont];
        //            [send setTitleColor:[ui] forState:UIControlStateNormal];
        [send setTitle:@"发布" forState:UIControlStateNormal];
        send.frame = CGRectMake(10, 30, kScreenWidth-20, 40);
        send.layer.cornerRadius = 20;
        send.layer.masksToBounds = YES;
        send.backgroundColor = MainTopColor;
        [send addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:send];
        
        return cell;
        
    }
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:YES];
    [self.toolBar hiddenView];
    if (indexPath.row == 1) {
        
        if (_model.product_id && ![_model.product_id isEmptyString]) {
//            LWHProjectDetailViewController *vc = [[LWHProjectDetailViewController alloc]init];
//            vc.ID = _model.product_id;
//            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        
        [self.view endEditing:YES];
        [self.toolBar hiddenView];
    }
  
}

- (void)sendBtnAction {
    
    [self.view endEditing:YES];
    [self.toolBar hiddenView];
    if (!self.selectPhotos.count && !self.selectVideo.count && !self.textView.text.length) {
        [LJCProgressHUD showStatueText:@"请填写发送内容"];
        return;
    }
    
    [LJCProgressHUD showAnnulusHud];
    
    if (self.selectVideo.count) {
        
        NSData *data = [NSData dataWithContentsOfFile:_videoUrl];
        
        [LJCNetWorking UpImageWithUrl:@"Upload_Video" params:@{@"type":@"2",@"file_name":@"upload-video",@"path":@"user"} data:data fileName:@"upload-video" progress:^(double progress) {
            
        } dataBlock:^(id data) {
//                        NSLog(@"----%@",data);
            if (data) {
                self->_videoUrl = data[@"data"][@"file_path"];
                [self issueAction];
            }
        }];
        
        
    } else {
        
        if (self.selectPhotos.count) {
            
            [LJCNetWorking UpImageWithUrl:@"Upload_Image" params:@{@"type":@"1",@"file_name":@"file_img",@"path":@"user"} withImageArray:self.selectPhotos progress:^(double progress) {
                //            NSLog(@"=%lf",progress);
            } dataBlock:^(id data) {
                //            NSLog(@"------%@",data);
                if (data) {
                    self->_imgUrl = data[@"data"][@"file_path"];
                    [self issueAction];
                } 
            }];
            
        } else {
            [self issueAction];
        }
    }
    
}

- (void)issueAction {
    
    NSDictionary *dic;
    
    if (self.selectVideo.count) {
        
        dic = @{@"bespeak_id":self.model.dataId,@"intro":self.textView.text,@"type":@"2",@"video_path":_videoUrl};
        
    } else {
        
        if (self.selectPhotos.count) {
            
            NSData *data= [NSJSONSerialization dataWithJSONObject:_imgUrl options:NSJSONWritingPrettyPrinted error:nil];
            
            NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            dic = @{@"bespeak_id":self.model.dataId,@"intro":self.textView.text,@"img_path":jsonStr,@"type":@"1"};
            
        } else {
            
            dic = @{@"bespeak_id":self.model.dataId,@"intro":self.textView.text};
            
        }
    }
//    NSLog(@"-------%@",dic);
    [LJCNetWorking POST_URL:@"Send_Diary" params:dic dataBlock:^(id data) {
//        NSLog(@"----%@",data);
        
//        [LJCProgressHUD hiddenHud];
        
        if (data) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"eload_Order_List" object:nil];
            
        }
        
    }];
}
- (void)confirmBtnAction {
    
    [self.view endEditing:YES];
    [self.toolBar hiddenView];
    LJCActionSheet *sheet = [LJCActionSheet actionSheetWithTitle:@"提示" confirms:@[@"拍摄",@"相册"] cancel:@"取消" style:LJCActionSheetStyleDefault];
    sheet.delegate = self;
    
    [sheet showInView:self.view.window];
    
}


- (void)clickAction:(LJCActionSheet *)actionSheet atIndex:(NSUInteger)index sheetTitle:(NSString *)title {
    
    if (index == 0) {
        
        [self takePhoto];
        
    } else if (index == 1) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
        imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
        imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按钮
        if (self.type == 1) {
            imagePickerVc.allowPickingVideo = NO;
        } else {
            imagePickerVc.allowPickingVideo = YES;
        }
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.allowPickingGif = YES;
//        imagePickerVc.allowPreview = NO;
        imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
        imagePickerVc.showPhotoCannotSelectLayer = YES;
        imagePickerVc.cannotSelectLayerColor = [UIColor colorWithWhite:1 alpha:.5];
        imagePickerVc.selectedAssets = self.selectedAssets; // 目前已经选中的图片数组
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
    }
    
}

// 调用相机
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        [self openJurisdiction];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        [self openJurisdiction];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}
// 权限开启提示
- (void)openJurisdiction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (self.type == 2) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
        }
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
//        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = NO;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                //                NSLog(@"图片保存失败 %@",error);
            } else {
                
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                
                [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(PHAsset *asset, NSError *error) {
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            
                            [self imagePickerController:tzImagePickerVc didFinishPickingVideo:photo sourceAssets:assetModel.asset];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    
    if (self.selectVideo.count) {
        
        return;
    }
    
    [_selectedAssets addObject:asset];
    
    [_selectPhotos addObject:image];
    
    [self.tableView reloadData];
    
}

#pragma mark - TZImagePickerControllerDelegate
// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    
}
// 点完成
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    //    NSLog(@"11111");
    if (self.selectVideo.count) {
        
        return;
    }
    
    self.selectPhotos = [[NSMutableArray alloc]initWithArray:photos];
    
    self.selectedAssets = [[NSMutableArray alloc]initWithArray:assets];
    
    [self.tableView reloadData];
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    if (_selectPhotos.count) {
        
        return;
    }
    [LJCProgressHUD showIndicatorWithText:@"视频正在导出"];
    _selectVideo = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    //
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetHighestQuality success:^(NSString *outputPath) {
        
        self->_videoUrl = outputPath;
        //        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        [LJCProgressHUD hiddenHud];
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    } failure:^(NSString *errorMessage, NSError *error) {
//        NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
        [LJCProgressHUD hiddenHud];
    }];
    [self.tableView reloadData];
    
}

#pragma mark UICollectionView


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.selectPhotos.count < 9 ? self.selectPhotos.count + 1 : self.selectPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    
    cell.videoImageView.hidden = YES;
    
    if (self.selectVideo.count) {
        cell.imageView.image = self.selectVideo[indexPath.item];
        cell.asset = _selectedAssets[indexPath.item];
        cell.deleteBtn.hidden = NO;
    } else {
        if (indexPath.item == self.selectPhotos.count) {
            cell.imageView.image = [UIImage imageNamed:@"auth_placeholder.jpg"];
            cell.deleteBtn.hidden = YES;
            
        } else {
            cell.imageView.image = self.selectPhotos[indexPath.item];
            cell.asset = _selectedAssets[indexPath.item];
            cell.deleteBtn.hidden = NO;
        }
    }
    
    cell.gifLable.hidden = YES;
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= self.selectedAssets.count) {
        if (self.selectVideo.count) {
            [self.selectVideo removeObjectAtIndex:sender.tag];
        } else {
            [self.selectPhotos removeObjectAtIndex:sender.tag];
        }
        [self.selectedAssets removeObjectAtIndex:sender.tag];
        [self.tableView reloadData];
        return;
    }
    
    if (self.selectVideo.count) {
        [self.selectVideo removeObjectAtIndex:sender.tag];
    } else {
        [self.selectPhotos removeObjectAtIndex:sender.tag];
    }
    [self.selectedAssets removeObjectAtIndex:sender.tag];
    [self.collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.tableView reloadData];
    }];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    [self.toolBar hiddenView];
    if (indexPath.item == self.selectedAssets.count) {
        LJCActionSheet *sheet = [LJCActionSheet actionSheetWithTitle:@"提示" confirms:@[@"拍摄",@"相册"] cancel:@"取消" style:LJCActionSheetStyleDefault];
        sheet.delegate = self;
        
        [sheet showInView:self.view.window];
        
    } else { // preview photos or video / 预览照片或者视频
        PHAsset *asset = _selectedAssets[indexPath.item];
        BOOL isVideo = NO;
        isVideo = asset.mediaType == PHAssetMediaTypeVideo;
        if ([[asset valueForKey:@"filename"] containsString:@"GIF"]) {
            TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else if (isVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:self.selectedAssets selectedPhotos:self.selectPhotos index:indexPath.item];
            imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
            imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按钮
            imagePickerVc.allowPickingVideo = YES;
            imagePickerVc.allowPickingImage = YES;
            imagePickerVc.allowPickingOriginalPhoto = NO;
            imagePickerVc.allowPreview = NO;
            imagePickerVc.showPhotoCannotSelectLayer = YES;
            imagePickerVc.cannotSelectLayerColor = [UIColor colorWithWhite:1 alpha:.5];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
}

#pragma mark - LxGridViewDataSource

/// 拖动imageView排序
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < self.selectedAssets.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < self.selectedAssets.count && destinationIndexPath.item < self.selectedAssets.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    if (self.selectVideo.count) {
        UIImage *image = self.selectPhotos[sourceIndexPath.item];
        [self.selectVideo removeObjectAtIndex:sourceIndexPath.item];
        [self.selectVideo insertObject:image atIndex:destinationIndexPath.item];
    } else {
        UIImage *image = self.selectPhotos[sourceIndexPath.item];
        [self.selectPhotos removeObjectAtIndex:sourceIndexPath.item];
        [self.selectPhotos insertObject:image atIndex:destinationIndexPath.item];
    }
    
    id asset = self.selectedAssets[sourceIndexPath.item];
    [self.selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [self.selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    [self.collectionView reloadData];
}

@end
