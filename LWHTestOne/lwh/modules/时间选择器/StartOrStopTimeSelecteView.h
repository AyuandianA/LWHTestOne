//
//  StartOrStopTimeSelecteView.h
//  TimeSelecte
//
//  Created by Aliang Ren on 2019/6/27.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StartOrStopTimeSelecteView;

@protocol StartOrStopTimeSelecteViewDelegate <NSObject>

- (void)didSelectTimeRange:(StartOrStopTimeSelecteView *_Nullable)view withRangeStr:(NSString *_Nullable)time;

@end

NS_ASSUME_NONNULL_BEGIN

@interface StartOrStopTimeSelecteView : UIView

@property(weak, nonatomic)id<StartOrStopTimeSelecteViewDelegate> delegate;

- (void)showSelecteTimeView;


@end

NS_ASSUME_NONNULL_END
