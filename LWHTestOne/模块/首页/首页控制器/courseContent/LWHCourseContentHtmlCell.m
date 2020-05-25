//
//  LWHProjectDetailHtmlCell.m
//  ChengXianApp
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "LWHCourseContentHtmlCell.h"
#import <WebKit/WebKit.h>


@interface LWHCourseContentHtmlCell ()
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
    //section == 0
    WKWebView *contentLable = [[WKWebView alloc]initWithFrame:CGRectMake(0,0,self.width,1)];
    self.contentLable = contentLable;
    contentLable.scrollView.scrollEnabled = NO;
    AdjustsScrollViewInsetNever([self viewController], contentLable.scrollView)
    contentLable.opaque =NO;
    [self.contentView addSubview:contentLable];
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        
    }];
    [self.contentLable.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    //section == 1 || 2
    YYLabel *titleLable = [[YYLabel alloc]init];
    titleLable.font = [UIFont systemFontOfSize:TextFont weight:1];
    titleLable.textColor = [UIColor colorWithWhite:0.1 alpha:1];
    titleLable.numberOfLines = 0;
    titleLable.preferredMaxLayoutWidth = KScreenWidth - self.margin * 2;
    [titleLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:titleLable];
    self.titleLable = titleLable;
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.margin);
        
    }];
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        //通过webview的contentSize获取内容高度
        CGFloat height = self.contentLable.scrollView.contentSize.height;
        if (!self.contentLable.isLoading) {
            [self.contentLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
                make.bottom.equalTo(self.contentView);
            }];
            [self.contentLable sizeToFit];
            [self.contentView layoutIfNeeded];
        }
        
    }
}

-(void)dealloc{
    [self.contentLable.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

-(void)changeDataWithModel:(id )model andSection:(NSInteger)section
{
    if (section == 0) {
        
    }else{
        [self.contentLable loadHTMLString:model baseURL:nil];
        [self.contentLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
        }];
    }
}

@end
//NSString *htmlString1 = [NSString stringWithFormat:@"<html> \n"
//"<head> \n"
//"<style type=\"text/css\"> \n"
// "body {font-size:%fpx;color:#696969}\n"
// "a {color:#1E90FF}\n"
//"</style> \n"
//"</head> \n"
//"<body>"
//"<script type='text/javascript'>"
//"window.onload = function(){\n"
//"var $img = document.getElementsByTagName('img');\n"
//"for(var p in  $img){\n"
//" $img[p].style.width = '100%%';\n"
//"$img[p].style.height ='auto'\n"
//"}\n"
//"}"
//"</script>%@"
//"</body>"
//"</html>",TextFont * 2.1, htmlString];
