//
//  LWHTableViewAutoHeight.h
//  LWHTestOne
//
//  Created by mac on 2020/5/9.
//  Copyright © 2020 BraveShine. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface LWHTableViewAutoHeight : UITableView

@property (nonatomic,strong) NSMutableArray *SourceArray;
+(instancetype)creatTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style;

@end
