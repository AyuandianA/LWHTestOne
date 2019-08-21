//
//  LJCSwitch.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/7/31.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJCSwitch;

typedef void (^LJCSwitchCompletionHandler)(void);
typedef void (^LJCSwitchBlock)(LJCSwitch *sw, LJCSwitchCompletionHandler completionHandler);

@interface LJCSwitch : UISwitch

- (void)addBlock:(LJCSwitchBlock)block; // completionHandler需要在执行完成之后调用，不能在方法开始的时候就执行，不然会导致状态不对

@end
