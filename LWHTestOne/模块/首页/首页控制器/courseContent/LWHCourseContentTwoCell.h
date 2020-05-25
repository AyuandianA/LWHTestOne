//
//  LWHCourseContentTwoCell.h
//  LWHTestOne
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWHCourseContentTwoCell : UITableViewCell
+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView;
-(void)changeDataWithModel:(id)model;
@end

NS_ASSUME_NONNULL_END
