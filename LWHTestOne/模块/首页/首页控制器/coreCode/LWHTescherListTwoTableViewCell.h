//
//  LWHTescherListTwoTableViewCell.h
//  LWHTestOne
//
//  Created by mac on 2020/5/21.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHTeacherListTwoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWHTescherListTwoTableViewCell : UITableViewCell
+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView;

-(void)changeDataWithModel:(LWHTeacherListTwoModel *)model;
@end

NS_ASSUME_NONNULL_END
