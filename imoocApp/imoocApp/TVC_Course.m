//
//  TVC_Course.m
//  imoocApp
//
//  Created by myApple on 16/3/17.
//  Copyright © 2016年 crane. All rights reserved.
//

#import "TVC_Course.h"

@interface TVC_Course ()

@end

@implementation TVC_Course
{
    NSArray *mArrBanner;
    UIScrollView *scrollV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSURL *url=[NSURL URLWithString:@"http://www.imooc.com/api3/getadv"];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[@"uid=308364&marking=banner&token=5060f8fa56743c0a9835ba0c340b491f"  dataUsingEncoding:NSUTF8StringEncoding] ];
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *mArrRevg=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            mArrBanner=[mArrRevg objectForKey:@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
            });
           
        });
    }];
        
 
   
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==3) {
        return 2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *strCell_ID=nil;
    switch (indexPath.section) {
        case 0:
            strCell_ID=@"scrollCell";
            break;
        case 1:
            strCell_ID=@"stackSplitCell";
            break;
        case 2:
            strCell_ID=@"courseList";
            break;
        default:
            strCell_ID=@"curseListCell";
            break;
    }
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:strCell_ID forIndexPath:indexPath];

    
    if (indexPath.section==0) {
        scrollV=[cell viewWithTag:1];
        scrollV.contentOffset=CGPointMake(0, 0);
        scrollV.contentSize=CGSizeMake(scrollV.frame.size.width*4, 0);
        for (int i=0; i<4; i++) {
                    UIImageView *img=[cell viewWithTag:2+i];
                    NSString *str=[[mArrBanner objectAtIndex:i]objectForKey:@"pic"];
                    img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
        }
    }
    else if(indexPath.section==1)
    {
        for (int i=0; i<2; i++) {
            UIImageView *img=[cell viewWithTag:1+i];
            NSString *str=[[mArrBanner objectAtIndex:i]objectForKey:@"pic"];
            img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
        }
    }
    else if(indexPath.section==3)
    {
        for (int i=0; i<1; i++) {
            UIImageView *img=[cell viewWithTag:1+i];
            NSString *str=[[mArrBanner objectAtIndex:i]objectForKey:@"pic"];
            img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
        }
    }
   return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 152;
        case 2:
            return 43;
    }
    return 94;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
