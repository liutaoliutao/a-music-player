











//52.上 2.33   2.44经典 strong weak

//2.31另外一种 页面跳转传值的方法  perform








#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
@interface ViewController ()<AVAudioPlayerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (weak, nonatomic) IBOutlet UISlider *volume;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *overTime;
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lableTwo;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIProgressView *progressVIew;
@property(nonatomic,assign) NSInteger num;
@property(nonatomic,strong)NSString *path;
@property(nonatomic,strong)NSTimer *time;
@property(nonatomic,weak)AppDelegate *app;
@property (weak, nonatomic) IBOutlet UITableView *lrcTableView;
@property(nonatomic,strong) NSMutableDictionary *timeAndTextDic;
@end

@implementation ViewController



-(void)playMusic{
    
    if (self.currentIndex<0) {
        self.currentIndex =self.musicPaths.count-1;
    }else if(self.currentIndex>self.musicPaths.count-1){
        self.currentIndex=0;
    }
    self.musicPath = self.musicPaths[self.currentIndex];
    
    
    
    
    /////////////////////// ///////////////////////
    NSString *lrcPath3 =[[self.musicPath componentsSeparatedByString:@"."]firstObject];
    NSString *lrcPath2= [lrcPath3 stringByAppendingString:@".lrc"];
//    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:lrcPath2];
//    NSData *data = [handle readDataToEndOfFile];
//    NSString *lrcPath = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *lrcPath = [NSString stringWithContentsOfFile:lrcPath2 encoding:NSUTF8StringEncoding error:nil];
    
    NSArray * lines = [lrcPath componentsSeparatedByString:@"\n"];
  self.timeAndTextDic  = [NSMutableDictionary dictionary];
    for (NSString *line in lines) {
        if ([line hasPrefix:@"["]) {
            NSArray *timeAndText = [line componentsSeparatedByString:@"]"];
            NSString *timeString = [[timeAndText firstObject]substringFromIndex:1];
            NSArray *times = [timeString componentsSeparatedByString:@":"];
           float time = [times[0] intValue]*60 + [times[1] intValue] ;
            
            [self.timeAndTextDic setObject:timeAndText[1] forKey:@(time)];
            
        }
    }
    
    ///////////////////////// ///////////////////////
    [self.lrcTableView reloadData];//??????似乎没有什么卵用
    
    
    self.app=[UIApplication sharedApplication].delegate;
    self.title = [[[self.musicPath lastPathComponent]componentsSeparatedByString:@"."]firstObject];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(back:)];
    
    self.app.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:self.musicPath] error:Nil];
    
    NSTimeInterval  time = self.app.player.duration;
    self.lableTwo.text =[NSString stringWithFormat:@"%.2d:%.2d",(int)time/60,(int)time%60];
    
    
    
    //NSLog(@"%f",self.app.player.duration)  ; //总时间,秒
    // self.app.player.currentTime//当前时间
    
    self.timeSlider.maximumValue = self.app.player.duration;
    self.time = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(ccCurrentTime:) userInfo:nil repeats:YES];
    [self.app.player play];
    
    self.app.player.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self playMusic];
    
    
    
}



- (IBAction)playOrpause:(UIButton*)sender {

    if (sender.tag == 2) {
        if (self.app.player.isPlaying) {
            [self.app.player pause];
            [self.button setTitle:@"播放" forState:UIControlStateNormal];
        }else{
            [self.app.player play];
            [self.button setTitle:@"暂停" forState:UIControlStateNormal];
        }
        
        
    }else if(sender.tag==1){
        self.currentIndex--;
        [self playMusic];
    }else{
        self.currentIndex++;
        [self playMusic];
    }
  
    
}

- (IBAction)volumeChange:(id)sender {
     self.app.player.volume = self.volume.value;
}



- (IBAction)dragSlider:(UISlider *)sender {
    self.app.player.currentTime = self.timeSlider.value;
//    self.lable1.text =[NSString stringWithFormat:@"%0.2d:%.2d",(int)self.timeSlider.value/60,(int)self.timeSlider.value%60];
}


-(void)ccCurrentTime:(NSTimer*)time{
    
    self.timeSlider.value = self.app.player.currentTime;
        self.lable1.text =[NSString stringWithFormat:@"%0.2d:%.2d",(int)self.timeSlider.value/60,(int)self.timeSlider.value%60];
    
    
    NSArray *keys = self.timeAndTextDic.allKeys;
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if([obj1 intValue]<[obj2 intValue]){
            return NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
        
    }];
    ///动态显示歌词
    
    for (int i=0; i<keys.count; i++) {
        int time = [keys[i]intValue];
        if (time>self.app.player.currentTime) {
            int line = i-1;
            
            [self.lrcTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:line inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            break;
        }
    }
    
    
    
    
    
    
}

//-(void)back:(UIBarButtonItem *)item{
//    [self.app.player stop];
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(void)dealloc{
    NSLog(@"页面被销毁了");
}
-(void)viewDisappear:(BOOL)animated{
    //self.app.player.delegate=nil;
    [self.time invalidate];
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (self.segment.selectedSegmentIndex==0) {
         self.currentIndex+=1;
        [self playMusic];
    }else if (self.segment.selectedSegmentIndex==1){
        //self.currentIndex=self.currentIndex;
        [self playMusic];
    }else{
        self.currentIndex = arc4random()%self.musicPaths.count;
        [self playMusic];
    }
   
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.timeAndTextDic.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    NSArray *keys = self.timeAndTextDic.allKeys;
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if([obj1 intValue]<[obj2 intValue]){
            return NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
        
    }];
            
         
    
    
    
    
  NSNumber *key= keys[indexPath.row];
    cell.textLabel.text = self.timeAndTextDic[key];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    cell.selectedBackgroundView = [[UIView alloc ]initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
   
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 15;
}


@end
