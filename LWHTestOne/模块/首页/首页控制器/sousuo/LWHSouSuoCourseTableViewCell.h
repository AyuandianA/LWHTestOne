//
//  LWHSouSuoCourseTableViewCell.h
//  zhibo
//
//  Created by 李武华 on 2020/5/22.
//  Copyright © 2020 李武华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWHSouSuoCourseTableViewCell : UITableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView;

-(void)changeDataWithModel:(NSDictionary *)dic;
-(void)changeDataWithModel:(NSDictionary *)dic andSection:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
