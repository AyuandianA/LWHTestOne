//
//  LWHShengJiVIPTableViewCell.h
//  LWHTestOne
//
//  Created by mac on 2020/5/22.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWHShengJiVIPTableViewCell : UITableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView;

-(void)changeDataWithModel:(NSDictionary *)dic;
-(void)changeDataWithModel:(NSDictionary *)dic andSection:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
