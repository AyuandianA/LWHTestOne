//
//  CZSocketManager.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/7/2.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "CZSocketManager.h"
#import <SocketRocket/SocketRocket.h>

static CZSocketManager *_socketManager = nil;
static dispatch_once_t onceToken;

@interface CZSocketManager ()<SRWebSocketDelegate>

@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)SRWebSocket *socket;

@end

@implementation CZSocketManager

+ (instancetype)shareSocket {
    
    dispatch_once(&onceToken, ^{
        
        if (!_socketManager) {
            _socketManager = [[CZSocketManager alloc] init];
        }
        
    });
    
    return _socketManager;
}

- (instancetype)init {
    
    if ([super init]) {
     
        [self connectSocket];
        
    }
    
    return self;
    
}

- (void)connectSocket {
    
//    if (!Encrypt_Id) {
//        
//        return;
//    }
//    
//    self.socket = [[SRWebSocket alloc]initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:CHAT_SOCKET]]];
//    
//    self.socket.delegate = self;
//    
//    [self.socket open];
    
}

#pragma mark webSocket代理方法 连接成功的方法
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
//    NSLog(@"2222");
    self.isConnect = YES;
    //    NSLog(@"连接成功，可以立刻登录你公司后台的服务器了，还有开启心跳");
    if (self.timer) {
        
        [self.timer invalidate];
        
        self.timer = nil;
    }
    
    if (!User_Id) {
        
        return;
    }
    
    [self sendDataDic:@{@"type":@"bind",@"uid":User_Id}];
    
}

- (void)sendDataDic:(NSDictionary *)dic {
    
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    [self sendData:jsonStr];
    
}

#pragma mark webSocket代理方法 连接失败的方法
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
    self.isConnect = NO;
    
    // 连接失败开启定时器，10秒重连一次
    self.timer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(sendConnect) userInfo:nil repeats:YES];
    //
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    //    NSLog(@"连接失败，这里可以实现掉线自动重连，要注意以下几点");
    //    NSLog(@"1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    //    NSLog(@"2.判断调用层是否需要连接，例如用户都没在聊天界面，连接上去浪费流量");
    //    NSLog(@"3.连接次数限制，如果连接失败了，重试10次左右就可以了，不然就死循环了。或者每隔1，2，4，8，10，10秒重连...f(x) = f(x-1) * 2, (x=5)");
}
- (void)sendConnect {
    
    [self repetitionConnectSocket];
}
#pragma mark webSocket代理方法 连接断开的方法
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    self.isConnect = NO;
    //
    [self repetitionConnectSocket];
    
}
- (void)repetitionConnectSocket {
    [self.socket close];
    self.socket = nil;
    [self.timer invalidate];
    self.timer = nil;
    [self connectSocket];
}
- (void)breakSocket {
    //    NSLog(@"bbbbbb");
    [self.socket close];
    self.socket = nil;
    [self.timer invalidate];
    self.timer = nil;
    
}
#pragma mark webSocket代理方法 收到数据的方法
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message  {
//    NSLog(@"message = %@",message);
    NSDictionary *dic = [self dictionaryWithJsonString:message];
    
    if ([dic[@"user_id"] intValue] == [User_Id intValue]) {
        
        return;
    }
    
    // type  chatmsg群聊
    if ([dic[@"type"] isEqualToString:@"msg"]) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveMessageData:)]) {
            
            [self.delegate didReceiveMessageData:dic];
        }
   
    } else if ([dic[@"type"] isEqualToString:@"recall"]) {
        // 收到撤回消息socket
        if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveMessageData:)]) {
            
            [self.delegate didReceiveMessageData:dic];
        }
        
    } else if ([dic[@"type"] isEqualToString:@"newblog"]) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveDynamicData:)]) {

            [self.delegate didReceiveDynamicData:dic];
        }
        
    }
    
}
- (void)sendData:(id)data {
    
    __weak __typeof(self)ws = self;
    
    dispatch_queue_t queue =  dispatch_queue_create("CZApp_chat", NULL);
    
    dispatch_async(queue, ^{
        if (ws.socket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法，不然要崩
            if (ws.socket.readyState == SR_OPEN) {
                [ws.socket send:data];    // 发送数据
//                NSLog(@"1111");
            } else if (ws.socket.readyState == SR_CONNECTING) {
                //                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                // 代码有点长，我就写个逻辑在这里好了
                
            } else if (ws.socket.readyState == SR_CLOSING || ws.socket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                [self.socket close];
                self.socket = nil;
                [self.timer invalidate];
                self.timer = nil;
                [self connectSocket];
                
            }
        }
        //        else {
        //            NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
        //            NSLog(@"其实最好是发送前判断一下网络状态比较好，我写的有点晦涩，socket==nil来表示断网");
        //        }
    });
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
