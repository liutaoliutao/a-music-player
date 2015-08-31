//
//  TRMusic.h
//  52天 50分 音乐播放器
//
//  Created by dlw on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRMusic : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *url;
+(NSArray*)musicDemo;
@end
