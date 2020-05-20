//
//  LWHPublicTableView.h
//  zhibo
//
//  Created by 李武华 on 2020/5/21.
//  Copyright © 2020 李武华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapSection)(NSIndexPath *indexPath);
@interface LWHPublicTableView : UITableView

@property (nonatomic,strong) NSMutableArray *PublicSourceArray;
@property (nonatomic,copy) NSString *cellName;
@property (nonatomic,copy) tapSection tapSection;
+(instancetype)creatPublicTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style;
@end
