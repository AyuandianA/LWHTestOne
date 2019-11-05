//
//  StartOrStopTimeSelecteView.m
//  TimeSelecte
//
//  Created by Aliang Ren on 2019/6/27.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import "StartOrStopTimeSelecteView.h"

//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define hScale ([UIScreen mainScreen].bounds.size.height) / 667

@interface StartOrStopTimeSelecteView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIPickerView *pickerV;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,copy)NSString *selecteOne;
@property (nonatomic,copy)NSString *selecteTwo;

@end


@implementation StartOrStopTimeSelecteView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
      
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260*hScale)];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgView];
        
        self.selecteOne = @"";
        self.selecteTwo = @"";
        
        self.dataArray = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < 24; i++) {
            
            if (i < 10) {
                [self.dataArray addObject:[NSString stringWithFormat:@"0%d:00",i]];
                [self.dataArray addObject:[NSString stringWithFormat:@"0%d:30",i]];
            } else {
                [self.dataArray addObject:[NSString stringWithFormat:@"%d:00",i]];
                [self.dataArray addObject:[NSString stringWithFormat:@"%d:30",i]];
            }
          
        }
        
        self.pickerV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, 260*hScale-SafeAreaH-40)];
        self.pickerV.delegate = self;
        self.pickerV.dataSource = self;
        [self.bgView addSubview:self.pickerV];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneBtn setTitleColor:MainTopColor forState:UIControlStateNormal];
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:TextFont];
        doneBtn.frame = CGRectMake(ScreenWidth-60, 0, 60, 39);
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(doneBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:doneBtn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitleColor:MainTopColor forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:TextFont];
        cancelBtn.frame = CGRectMake(0, 0, 60, 39);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:cancelBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39, ScreenWidth, 1)];
        line.backgroundColor = MainBackColor;
        [self.bgView addSubview:line];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, ScreenWidth-120, 39)];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"选择时间范围";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:TextFont-3];
        [self.bgView addSubview:label];
        
    }
    
    return self;
    
}

- (void)doneBtnAction {
    
    [self hiddenSelectTimeView];
    
    if ([self compareTime:self.dataArray[[self.selecteOne integerValue]] withTime:self.dataArray[[self.selecteTwo integerValue]]] == -1) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectTimeRange:withRangeStr:)]) {
            [self.delegate didSelectTimeRange:self withRangeStr:[NSString stringWithFormat:@"%@-%@",self.dataArray[[self.selecteOne integerValue]],self.dataArray[[self.selecteTwo integerValue]]]];
        }
        
    } else {
        
        [LJCProgressHUD showStatueText:@"请选择正确时间范围"];
        
    }
   
    
}

// 比较时间大小
- (NSComparisonResult)compareTime:(NSString *)time1 withTime:(NSString *)time2 {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"HH:mm"];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDate *sDate = [NSDate dateWithTimeInterval:8*60*60 sinceDate:[formatter dateFromString:time1]];
    
    NSDate *eDate = [NSDate dateWithTimeInterval:8*60*60 sinceDate:[formatter dateFromString:time2]];
    
    NSComparisonResult result = [sDate compare:eDate];
    //    NSLog(@"-------%ld",(long)result);
    return result;
    
}

- (void)cancelBtnAction {
    
    [self hiddenSelectTimeView];
    
}

#pragma mark-----UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return  2;
 
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataArray.count;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:TextFont];
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return label;
    
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
        if (component == 0) {
            self.selecteOne = [NSString stringWithFormat:@"%ld",row];
            [pickerView reloadComponent:1];
        } else {
            self.selecteTwo = [NSString stringWithFormat:@"%ld",row];
        }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.dataArray[row];
  
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return (ScreenWidth - 30)/2;
    
}

- (void)hiddenSelectTimeView {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bgView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 260*hScale);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)showSelecteTimeView {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
       
        self.bgView.frame = CGRectMake(0, ScreenHeight-260*hScale, ScreenWidth, 260*hScale);
       
    }];
    
}

@end
