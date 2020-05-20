//
//  LWHTeacherListTableViewCell.h
//  LWHTestOne
//
//  Created by mac on 2020/5/20.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^TeacherListTableViewCellBlock)(int num);

@interface LWHTeacherListTableViewCell : UITableViewCell
@property (nonatomic,copy) TeacherListTableViewCellBlock myBlock;


+(instancetype)creatTeacherListTableViewCellWithTableView:(UITableView *)tableView;

-(void)changeDataWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
