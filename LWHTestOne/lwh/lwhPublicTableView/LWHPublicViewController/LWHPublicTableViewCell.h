//
//  LWHPublicTableViewCell.h
//  zhibo
//
//  Created by 李武华 on 2020/5/21.
//  Copyright © 2020 李武华. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LWHPublicTableViewCell : UITableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView;
-(void)changeDataWithModel:(id)model;
-(void)changeDataWithModel:(id)model andSection:(NSIndexPath *)section;
@end

NS_ASSUME_NONNULL_END
