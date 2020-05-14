//
//  LoginViewController.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/18.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "LoginViewController.h"
#import "LSNavigationController.h"
#import "BaseTabbarController.h"
#import "CZSocketManager.h"
#import "AppDelegate.h"
@interface LoginViewController () {
    
    UITextField *_telText;
    UITextField *_codeText;
    UIButton *_codeBtn;
    UIButton *_btn;
    NSString *_user;
    
}

@property (nonatomic,strong)UIButton *selectButton;
@end

@implementation LoginViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Login_Succ" object:_user];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:@"Login_Succ" object:nil];
    
    self.navigationBar.hidden = YES;
    
    UIButton *closeBtn = [[UIButton alloc]init];
    closeBtn.frame = CGRectMake(0, StatusHeight+4, 60, 40);
    [closeBtn setImage:BundleTabeImage(@"login_close.png") forState:UIControlStateNormal];
    [closeBtn setImage:BundleTabeImage(@"login_close.png") forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 5, 25);
    [self.view addSubview:closeBtn];
    
    UILabel *welcome = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(closeBtn.frame)+60, kScreenWidth-60, 60)];
    welcome.font = [UIFont boldSystemFontOfSize:TextFont+5];
    welcome.numberOfLines = 0;
    if (self.type == 1) {
        welcome.text = @"您好，\n欢迎来到橙赞";
    } else if (self.type == 2) {
        welcome.text = @"您好，\n请绑定您的手机号";
    } else {
        welcome.text = @"您好，\n请修改您的手机号";
    }
    
    [self.view addSubview:welcome];
    
    _telText = [[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(welcome.frame)+30, kScreenWidth-60, 40)];
    _telText.font = [UIFont systemFontOfSize:TextFont];
    _telText.placeholder = @"手机：+86";
    _telText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_telText];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(50, CGRectGetMaxY(_telText.frame), kScreenWidth-60, 1);
    lineLabel.backgroundColor = MainBackColor;
    [self.view addSubview:lineLabel];
    
    _codeText = [[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(lineLabel.frame)+20, kScreenWidth-60-70, 40)];
    _codeText.font = [UIFont systemFontOfSize:TextFont];
    _codeText.placeholder = @"验证码：";
    _codeText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_codeText];
    
    _codeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _codeBtn.frame= CGRectMake(kScreenWidth-30-70,CGRectGetMaxY(lineLabel.frame)+20, 70, 40);
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_codeBtn setTitleColor:MainTopColor forState:UIControlStateNormal];
    [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_codeBtn addTarget:self action:@selector(sendTestCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codeBtn];
    
    UILabel *lineLabel1 = [[UILabel alloc]init];
    lineLabel1.frame = CGRectMake(50, CGRectGetMaxY(_codeText.frame), kScreenWidth-60, 1);
    lineLabel1.backgroundColor = MainBackColor;
    [self.view addSubview:lineLabel1];
    
//    if (self.type == 1) {
//
//
//
//    }
   
    _btn = [UIButton buttonWithType: UIButtonTypeCustom];
    _btn.frame = CGRectMake(30, CGRectGetMaxY(_codeText.frame)+60, kScreenWidth-60, 40);
    if (self.type == 1) {
        [_btn setTitle:@"登录" forState:UIControlStateNormal];
    } else {
        [_btn setTitle:@"确定" forState:UIControlStateNormal];
    }
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:TextFont];
    _btn.backgroundColor = RGB(210, 216, 230 ,1);
    _btn.layer.cornerRadius = 3;
    _btn.layer.masksToBounds = YES;
    _btn.userInteractionEnabled = NO;
    [_btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    if (self.type == 1) {
        
        [self creatButtons];
        
        
    }
  
    // 监听 UITextField 输入变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    
}
-(void)creatButtons
{
    UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [selectButton setImage:[UIImage imageNamed:@"xuanzhongyuandian"] forState:(UIControlStateNormal)];
    [selectButton setImage:[UIImage imageNamed:@"xuanzhong"] forState:(UIControlStateSelected)];
    selectButton.selected = YES;
    self.selectButton = selectButton;
    [selectButton addTarget:self action:@selector(selectButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:selectButton];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_codeText.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(25);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        
    }];
   
    UIButton *agreementButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    agreementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [agreementButton setTitle:@"用户使用协议" forState:(UIControlStateNormal)];
    [agreementButton setTitleColor: RGB(150, 150, 150, 1) forState:(UIControlStateNormal)];
    agreementButton.titleLabel.font = [UIFont systemFontOfSize:TextFont - 3];
    [agreementButton addTarget:self action:@selector(agreementButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:agreementButton];
    [agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self->_codeText.mas_bottom).offset(10);
        make.left.equalTo(selectButton.mas_right).offset(-9);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(44);
        
    }];
}

-(void)agreementButtonAction
{
//    LWHSurgeryDetailViewController *detailVC = [[LWHSurgeryDetailViewController alloc]init];
//    detailVC.urlString = @"https://cxapi.yimeiq.cn/authopen/user-protocol";
//    detailVC.titleOne = @"用户使用协议";
//    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)selectButtonAction
{
    _selectButton.selected = !_selectButton.selected;
    
}

- (void)login:(NSNotification *)noti {
    
    _user = noti.object;

    LoginViewController *vc = [[LoginViewController alloc]init];
    //
    vc.type = 2;
    
    vc.userInfo = _user;
   
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)closeBtnAction {
    
    [self.view endEditing:YES];
    
    if (self.type == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [UIView animateWithDuration:.4 animations:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
   
}
// 发送验证码
- (void)sendTestCodeBtn {
    
    if ([_telText.text isPhoneNummber]) {

//        [MBProgressHUD showMessag:@""];

        NSDictionary *dic = @{@"phone":_telText.text,
                              };
        [LJCNetWorking POST_URL:@"Send_Code" params:dic dataBlock:^(id data) {
            if (data) {

                [LJCProgressHUD showStatueText:@"验证码已发送"];

                [self startTheTimer];

            }
        }];

    }else{

        [LJCProgressHUD showStatueText:@"手机号错误,请重新输入"];
    }
    
}
//定时器
-(void)startTheTimer{
    //    NSLog(@"执行");
    __block int timeout = 89;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self->_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self->_codeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = timeout % 90;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self->_codeBtn setTitle:[NSString stringWithFormat:@"剩余%@秒",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self->_codeBtn.userInteractionEnabled = NO;
                
            });
            
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
- (void)weiChatButtonClick {
    
    if (!self.selectButton.selected) {
        
        [LJCProgressHUD showStatueText:@"请先阅读并同意用户使用协议"];
        
        return;
    }


}

// 登录
- (void)clickBtn {
    
    [self.view endEditing:YES];
    
    if (self.type == 1) {
        if (!self.selectButton.selected) {
            
            [LJCProgressHUD showStatueText:@"请先阅读并同意用户使用协议"];
            
            return;
        }
    }
    
    if (![_telText.text isPhoneNummber]) {
        
        [LJCProgressHUD showStatueText:@"手机号错误,请重新输入"];
        
        return;
    }
    
    if (!_codeText.text.length) {
        
        [LJCProgressHUD showStatueText:@"请输入验证码"];
        
        return;
        
    }
    
    
    [LJCProgressHUD showAnnulusHud];
    
    if (self.type == 1) {
        
        [LJCNetWorking POST_URL:@"Tel_Login" params:@{@"phone":_telText.text,@"code":_codeText.text} dataBlock:^(id data) {
//            NSLog(@"~~~%@",data);
            if (data) {
                
                if ([data[@"error"] intValue] == 994) {
                    
                    [self showAlert:data[@"data"]];
                    
                } else {
                    
                    [LJCProgressHUD showIndicatorWithText:@"正在进入"];
                    
                    [self loginSucc:data[@"data"]];
                    
                }
               
            }
       
        }];
        
    } else if (self.type == 2) {
        
        [LJCNetWorking POST_URL:@"Bind_Tel" params:@{@"phone":_telText.text,@"code":_codeText.text,@"user_info":self.userInfo} dataBlock:^(id data) {
//            NSLog(@"---%@",data);
            if (data) {
                
                if ([data[@"error"] intValue] == 994) {
                    [self showAlert:data[@"data"]];
                } else {
                    
                    [LJCProgressHUD showIndicatorWithText:@"正在进入"];
                    
                    [self loginSucc:data[@"data"]];
                    
                }
              
            }
        
        }];
        
    } else {
        
        [LJCNetWorking POST_URL:@"Revise_Tel" params:@{@"phone":_telText.text,@"code":_codeText.text} dataBlock:^(id data) {

            if (data) {
                
                if ([data[@"error"] intValue] == 994) {
                     [self showAlert:data[@"data"]];
                } else {
                    [UserMaterialModel shareUser].telphone = self->_telText.text;
                    
                    [UIView animateWithDuration:.4 animations:^{
                        
                        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                        
                    }];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"Open_Noti" object:nil];
                }
               
            }
            
        }];
        
    }
    
}
- (void)showAlert:(NSDictionary *)dic {
    
//    SkillSelecteViewController *skill = [[SkillSelecteViewController alloc]init];
//    skill.userDic = dic;
//    [self.navigationController pushViewController:skill animated:YES];
  
}
- (void)loginSucc:(NSDictionary *)dic {

    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    NSArray *keys = [mDic allKeys];
    
    for (NSString *key in keys) {
        if ([[mDic objectForKey:key] isKindOfClass:[NSNull class]]) {
            [StorageManager setObj:@"" forKey:[NSString stringWithFormat:@"%@",key]];
        } else {
            [StorageManager setObj:mDic[key] forKey:[NSString stringWithFormat:@"%@",key]];
        }
    }
    
    [LJCNetWorking POST_URL:@"User_Material" params:nil dataBlock:^(id data) {

        if (data) {
            
            [[UserMaterialModel shareUser] modelSetWithDictionary:data[@"data"][@"info"]];
            [[UserMaterialModel shareUser] setOrderNumber:data[@"data"]];
            [StorageManager setObj:data[@"data"] forKey:@"user_material_data"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Reload_Data_Source" object:nil];
            [self push];
            
        }
        
        [[CZSocketManager shareSocket] repetitionConnectSocket];
        
    }];

    
}

- (void)push {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    BaseTabbarController *tab = [[BaseTabbarController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;

}
- (void)textFieldTextDidChange {
    if (![_telText.text isEmptyString] && ![_codeText.text isEmptyString ]) {
        _btn.userInteractionEnabled = YES;
        _btn.backgroundColor = MainTopColor;
    } else {
        _btn.backgroundColor = RGB(210, 216, 230 ,1);
        _btn.userInteractionEnabled = NO;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
