//
//  TableViewController.m
//  52天 50分 音乐播放器
//
//  Created by dlw on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "TableViewController.h"
#import "TRMusic.h"
#import "ViewController.h"
@interface TableViewController ()
@property(nonatomic,strong)NSMutableArray *musicArray;

@end

@implementation TableViewController
//-(NSArray *)musicArray{
//    if (!_musicArray) {
//        _musicArray = [TRMusic musicDemo];
//        
//    }return _musicArray;
//}
-(NSMutableArray *)musicArray{
    if (!_musicArray) {
        _musicArray = [NSMutableArray array];
    }return _musicArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSString *path = @"/Users/tarena/Desktop/音乐";
    NSFileManager *fileManger = [NSFileManager defaultManager];
   NSArray *fileNames = [fileManger contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in fileNames) {
        if ([fileName hasSuffix:@".mp3"]) {
            NSString *fullName = [path stringByAppendingPathComponent:fileName];
            [self.musicArray addObject:fullName];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.musicArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *musicPath = self.musicArray[indexPath.row];
    cell.textLabel.text = [[[musicPath lastPathComponent]componentsSeparatedByString:@"."]firstObject];
    //cell.detailTextLabel.text = music.url ;
   
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *musicPath = self.musicArray[indexPath.row];
//    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"playVc"];
//    vc.musicPath = musicPath;
//    
//    [self.navigationController pushViewController:vc
//                                         animated:YES];
    
   // NSString *musicPath = self.musicArray[indexPath.row];
    //[self performSegueWithIdentifier:@"playVc" sender:musicPath];
   [self performSegueWithIdentifier:@"playVc" sender:@(indexPath.row)];
    [ @(indexPath.row) intValue];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *vc = segue.destinationViewController;
    //vc.musicPath = sender ;
    vc.musicPaths =self.musicArray;
    vc.currentIndex = [sender integerValue];
}


@end
