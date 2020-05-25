//
//  LWHProjectDetailHtmlCell.h
//  ChengXianApp
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 WuHua . All rights reserved.
//


#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LWHCourseContentHtmlCell : UITableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView;
-(void)changeDataWithModel:(id)model andSection:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
