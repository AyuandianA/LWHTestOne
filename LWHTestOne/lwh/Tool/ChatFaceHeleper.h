//
//  ChatFaceHeleper.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/6.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatFaceHeleper : NSObject

@property (nonatomic, strong) NSMutableArray *faceGroupArray;

+ (ChatFaceHeleper *) sharedFaceHelper;

- (NSArray *) getFaceArrayByGroupID:(NSString *)groupID;

@end
