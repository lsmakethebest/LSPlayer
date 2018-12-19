

//
//  LSTableViewCell.m
//  LSPlayer
//
//  Created by ls on 16/3/8.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSPlayerView.h"
#import "LSTableViewCell.h"
#import "LSPlayerView.h"
#import <UIImageView+AFNetworking.h>

@interface LSTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end
@implementation LSTableViewCell

+ (instancetype)cellWithTabelView:(UITableView*)tableview
{
    static NSString* identifier = @"cell";
    LSTableViewCell* cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    [cell bringSubviewToFront:cell.playBtn];
    cell.playBtn.layer.cornerRadius = 30;
    cell.playBtn.layer.masksToBounds = YES;
    cell.playBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.playBtn.layer.borderWidth = 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)setModel:(LSMediaModel *)model
{
    _model=model;
    self.sourceLabel.text=model.videosource;
    self.introductionLabel.text=model.myDescription;
    [self.picView setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    self.timeLabel.text=[NSString stringWithFormat:@"%ld",model.length];
}
- (IBAction)playClick:(id)sender
{
    LSPlayerView* playerView = [LSPlayerView playerView];
    playerView.index=self.index;
    playerView.currentFrame=self.frame;
    
    //必须先设置tempSuperView在设置videoURL
    UITableView *tableview=self.superview;
    if (![tableview isKindOfClass:[UITableView class]]) {
        tableview=tableview.superview;
    }
    playerView.tempSuperView=self.superview.superview;
    playerView.videoURL=self.model.mp4_url;
    
}

@end
