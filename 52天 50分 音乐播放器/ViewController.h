//
//  ViewController.h
//  52天 50分 音乐播放器
//
//  Created by dlw on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRMusic.h"
@interface ViewController : UIViewController
@property(nonatomic,strong)NSString *musicPath;
@property(nonatomic,strong)NSArray *musicPaths;
@property(nonatomic)NSInteger currentIndex;
@end

