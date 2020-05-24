//
//  LWHVIPFuWuTableViewCell.h
//  zhibo
//
//  Created by 李武华 on 2020/5/22.
//  Copyright © 2020 李武华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHPublicTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface LWHVIPFuWuTableViewCell : UITableViewCell
+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView;
-(void)changeDataWithModel:(id _Nullable *_Nullable)model;
-(void)changeDataWithModel:(id _Nullable *_Nullable)model andSection:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
