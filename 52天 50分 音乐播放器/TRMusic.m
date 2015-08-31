//
//  TRMusic.m
//  52天 50分 音乐播放器
//
//  Created by dlw on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "TRMusic.h"

@implementation TRMusic
+(NSArray*)musicDemo{
    TRMusic *music = [[TRMusic alloc]init];
    music.name = @"捉放曹";
    music.url = @"/Users/tarena/Music/iTunes/iTunes Media/Music/王佩瑜/京剧之星/捉放曹 - 听他言吓得我心惊胆怕.m4a";
    
    TRMusic *musicTwo = [[TRMusic alloc]init];
    musicTwo.name = @"捉放曹";
    musicTwo.url = @"/Users/tarena/Music/iTunes/iTunes Media/Music/王佩瑜/京剧之星/捉放曹 - 听他言吓得我心惊胆怕.m4a";
    return @[music,musicTwo];
}

@end
