//
//  YXDayCell.m
//  Calendar
//
//  Created by Vergil on 2017/7/6.
//  Copyright © 2017年 Vergil. All rights reserved.
//

#import "YXDayCell.h"
#import "SXYCircle.h"

@interface YXDayCell ()

@property (weak, nonatomic) IBOutlet UILabel *dayL;     //日期
@property (weak, nonatomic) IBOutlet UIView *pointV;    //点
@property (nonatomic, strong) SXYCircle *circleView;

@end

@implementation YXDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _dayL.layer.cornerRadius = dayCellH / 2;
    _pointV.layer.cornerRadius = 1.5;
    
    _circleView = [[SXYCircle alloc] initWithFrame:CGRectMake(0, 0, dayCellH, dayCellH)];
    [_dayL addSubview:_circleView];
}

//MARK: - setmethod

- (void)setCellDate:(NSDate *)cellDate {
    _cellDate = cellDate;
    if (_type == CalendarType_Week) {
        [self showDateFunction];
    } else {
        if ([[YXDateHelpObject manager] checkSameMonth:_cellDate AnotherMonth:_currentDate]) {
            [self showDateFunction];
        } else {
            [self showSpaceFunction];
        }
    }
    
}

//MARK: - otherMethod

- (void)showSpaceFunction {
    self.userInteractionEnabled = NO;
    _dayL.text = @"";
    _dayL.backgroundColor = [UIColor clearColor];
    _dayL.layer.borderWidth = 1;
    _dayL.layer.borderColor = [UIColor whiteColor].CGColor;
    _pointV.hidden = YES;
}

- (void)showDateFunction {
    
    self.userInteractionEnabled = YES;
    
    _dayL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"d" Date:_cellDate];
    if ([[YXDateHelpObject manager] isSameDate:_cellDate AnotherDate:[NSDate date]]) {
        _dayL.layer.borderWidth = 1.5;
        _dayL.layer.borderColor = [UIColor orangeColor].CGColor;
    } else {
        _dayL.layer.borderWidth = 0;
        _dayL.layer.borderColor = [UIColor clearColor].CGColor;
    }
    if (_selectDate) {
        
        if ([[YXDateHelpObject manager] isSameDate:_cellDate AnotherDate:_selectDate]) {
            _dayL.backgroundColor = [UIColor orangeColor];
            _dayL.textColor = [UIColor whiteColor];
            _pointV.backgroundColor = [UIColor whiteColor];
        } else {
            _dayL.backgroundColor = [UIColor clearColor];
            _dayL.textColor = [UIColor blackColor];
            _pointV.backgroundColor = [UIColor orangeColor];
        }
        
    }
}

- (void)showCircle{
    
    NSString *currentDate = [[YXDateHelpObject manager] getStrFromDateFormat:@"MM-dd" Date:_cellDate];
    
    _circleView.hidden = YES;
    if (_eventArray.count) {
        for (NSString *strDate in _eventArray) {
            if ([strDate isEqualToString:currentDate]) {
                _circleView.hidden = NO;
                
                //_pointV.hidden = NO;
            }
        }
    }
}
- (void)drawCircle{
//    NSString *currentDate = [[YXDateHelpObject manager] getStrFromDateFormat:@"MM-dd" Date:_cellDate];
//    _pointV.hidden = YES;
//    _circleView.hidden = YES;
//    if (_eventArray.count) {
//        for (NSString *strDate in _eventArray) {
//            if ([strDate isEqualToString:currentDate]) {
//                _circleView.hidden = NO;
//
//                [_circleView createCricleByLocationisTop:NO color:[UIColor redColor]];
//                //[_circleView stareAnimationWithPercentage:0.5];
//
//                [_circleView createCricleByLocationisTop:YES color:[UIColor blueColor]];
//                //[_circleView stareAnimationWithPercentage:0.5];
//                //[_circleView stareAnimationWithPercentage:1];
//                //_pointV.hidden = NO;
//            }
//        }
//    }
}

@end
