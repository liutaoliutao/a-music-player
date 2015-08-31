//
//  AppDelegate.h
//  52天 50分 音乐播放器
//
//  Created by dlw on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)AVAudioPlayer *player;
@end

