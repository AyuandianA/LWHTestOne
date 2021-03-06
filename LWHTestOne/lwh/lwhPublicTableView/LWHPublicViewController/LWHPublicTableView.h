//
//  LWHPublicTableView.h
//  zhibo
//
//  Created by 李武华 on 2020/5/21.
//  Copyright © 2020 李武华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapSection)(NSIndexPath *indexPath);
typedef void(^scrollSection)(void);
typedef CGFloat(^headerHeight)(NSInteger section);
typedef UIView *(^headerView)(NSInteger section);
typedef CGFloat(^footerHeight)(NSInteger section);
typedef UIView *(^footerView)(NSInteger section);
typedef NSInteger(^cellSections)(void);
typedef NSInteger(^cellRows)(NSInteger section);
@interface LWHPublicTableView : UITableView

@property (nonatomic,strong) NSMutableArray *PublicSourceArray;

@property (nonatomic,copy) NSString *cellName;

@property (nonatomic,copy) tapSection tapSection;
@property (nonatomic,copy) scrollSection scrollSection;
@property (nonatomic,copy) cellSections cellSections;
@property (nonatomic,copy) cellRows cellRows;
@property (nonatomic,copy) headerHeight headerHeight;
@property (nonatomic,copy) headerView headerView;
@property (nonatomic,copy) footerHeight footerHeight;
@property (nonatomic,copy) footerView footerView;
+(instancetype)creatPublicTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style;
//不带表头表尾的中间内容总高度
-(CGFloat)getCellTableViewHeight;
@end
