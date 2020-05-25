//
//  LWHProjectDetailHtmlCell.m
//  ChengXianApp
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "LWHCourseContentHtmlCell.h"
#import <WebKit/WebKit.h>


@interface LWHCourseContentHtmlCell ()<WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *contentLable;
@property (nonatomic,strong) YYLabel *titleLable;
@property (nonatomic,strong) YYLabel *titleBottomLable;
@property (nonatomic,strong) YYLabel *nameLable;
@property (nonatomic,strong) YYLabel *nameRightLable;
@property (nonatomic,assign) CGFloat margin;
@end

@implementation LWHCourseContentHtmlCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView
{
    LWHCourseContentHtmlCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHCourseContentHtmlCell"];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[LWHCourseContentHtmlCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LWHCourseContentHtmlCell"];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.margin = 10;
        //初始化控件
        [self chuShiHua];
    }
    return self;
}

//初始化数据
-(void)chuShiHua
{
    self.backgroundColor = [UIColor whiteColor];
    //section == 1 || 2
    WKWebView *contentLable = [[WKWebView alloc]initWithFrame:CGRectMake(0,0,self.width,1)];
    self.contentLable = contentLable;
    contentLable.navigationDelegate = self;
    contentLable.scrollView.scrollEnabled = NO;
    AdjustsScrollViewInsetNever([self viewController], contentLable.scrollView)
    contentLable.opaque =NO;
    [self.contentView addSubview:contentLable];
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.margin);
        make.left.equalTo(self.contentView).offset(self.margin);
        make.right.equalTo(self.contentView).offset(-self.margin);
        make.bottom.equalTo(self.contentView).offset(-self.margin);
    }];
    //section == 0
    YYLabel *titleLable = [[YYLabel alloc]init];
    titleLable.font = [UIFont systemFontOfSize:TextFont weight:1];
    titleLable.textColor = [UIColor blackColor];
    titleLable.numberOfLines = 0;
    titleLable.preferredMaxLayoutWidth = KScreenWidth - self.margin * 2;
    [titleLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:titleLable];
    self.titleLable = titleLable;
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.margin);
        make.left.equalTo(self.contentView).offset(self.margin);
    }];
    
    YYLabel *titleBottomLable = [[YYLabel alloc]init];
    titleBottomLable.font = [UIFont systemFontOfSize:TextFont - 1 weight:-0.2];
    titleBottomLable.textColor = [UIColor redColor];
    titleBottomLable.numberOfLines = 0;
    titleBottomLable.preferredMaxLayoutWidth = KScreenWidth - self.margin * 2;
    [titleBottomLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:titleBottomLable];
    self.titleBottomLable = titleBottomLable;
    [titleBottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset(self.margin);
        make.left.equalTo(self.contentView).offset(self.margin);
    }];
    
    YYLabel *nameLable = [[YYLabel alloc]init];
    nameLable.font = [UIFont systemFontOfSize:TextFont - 1 weight:-0.2];
    nameLable.textColor = [UIColor blackColor];
    nameLable.numberOfLines = 0;
    nameLable.preferredMaxLayoutWidth = 150;
    [nameLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:nameLable];
    self.nameLable = nameLable;
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBottomLable.mas_bottom).offset(self.margin);
        make.left.equalTo(self.contentView).offset(self.margin);
        make.bottom.equalTo(self.contentView).offset(-self.margin);
    }];
    
    
}


-(void)changeDataWithModel:(id )model andSection:(NSIndexPath *)section
{
    if (section.section == 0) {
        self.titleLable.text = model;
        self.titleBottomLable.text = @"¥2887.00 | 两节";
        self.nameLable.text = @"孔令伟老师";
        self.contentLable.hidden = YES;
        self.titleLable.hidden = NO;
        self.titleBottomLable.hidden = NO;
        self.nameLable.hidden = NO;
        [self.titleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(self.margin);
            make.left.equalTo(self.contentView).offset(self.margin);
        }];
        [self.contentLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
    }else{
        NSString *htmlString1 = [NSString stringWithFormat:@"<html> \n"
        "<head> \n"
        "<style type=\"text/css\"> \n"
         "body {font-size:%fpx;color:#696969}\n"
         "a {color:#1E90FF}\n"
        "</style> \n"
        "</head> \n"
        "<body>"
        "<script type='text/javascript'>"
        "window.onload = function(){\n"
        "var $img = document.getElementsByTagName('img');\n"
        "for(var p in  $img){\n"
        " $img[p].style.width = '100%%';\n"
        "$img[p].style.height ='auto'\n"
        "}\n"
        "}"
        "</script>%@"
        "</body>"
        "</html>",TextFont * 2.1, model];
        [self.contentLable loadHTMLString:htmlString1 baseURL:nil];
        self.contentLable.hidden = NO;
        self.titleLable.hidden = YES;
        self.titleBottomLable.hidden = YES;
        self.nameLable.hidden = YES;
        [self.contentLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(self.margin);
            make.left.equalTo(self.contentView).offset(self.margin);
            make.right.equalTo(self.contentView).offset(-self.margin);
            make.bottom.equalTo(self.contentView).offset(-self.margin);
            make.height.mas_equalTo(100);
        }];
        [self.titleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
    }
}

@end
//改变HTML中字体大小

