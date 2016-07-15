//
//  ViewController.m
//  倒计时
//
//  Created by 丁瑞瑞 on 15/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "ViewController.h"
#import "CountDown.h"
@interface ViewController ()
//发送验证码
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
/** CountDownBtn倒计时按钮*/
@property (nonatomic,strong) CountDown *countDownBtn;
/** CountDownLabel倒计时文本*/
@property (nonatomic,strong) CountDown *countDownLabel;
//天
@property (weak, nonatomic) IBOutlet UILabel *days;
//时
@property (weak, nonatomic) IBOutlet UILabel *hours;
//分
@property (weak, nonatomic) IBOutlet UILabel *minutes;
//秒
@property (weak, nonatomic) IBOutlet UILabel *seconds;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.countDownBtn = [[CountDown alloc] init];
    self.countDownLabel = [[CountDown alloc] init];
    
//    1.使用时间戳倒计时
    long long startLongLong = 1467713971000;
    long long finishLongLong = 1467714322000;
    [self startLongLongStartStamp:startLongLong longlongFinishStamp:finishLongLong];
//    2.使用NSDate
}

- (IBAction)timeBtn:(id)sender {
//    倒计时的时间 60s
    NSTimeInterval aMinutes = 60;
//    一个小时的倒计时
//    NSTimeInterval aHours = 60 * 60;
//    一天的倒计时
//    NSTimeInterval aDays = 24 * 60 * 60;
    [self startWithStartDate:[NSDate date] finishDate:[NSDate dateWithTimeIntervalSinceNow:aMinutes]];
}


//1.此方法用两个时间戳做参数进行倒计时
-(void)startLongLongStartStamp:(long long)strtLL longlongFinishStamp:(long long)finishLL{
    __weak __typeof(self) weakSelf= self;
    
    [self.countDownLabel countDownWithStratTimeStamp:strtLL finishTimeStamp:finishLL completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        [weakSelf refreshUIDay:day hour:hour minute:minute second:second];
    }];
}

-(void)refreshUIDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    if (day==0) {
        self.days.text = @"0天";
    }else{
        self.days.text = [NSString stringWithFormat:@"%ld天",(long)day];
    }
    if (hour<10&&hour) {
        self.hours.text = [NSString stringWithFormat:@"0%ld小时",(long)hour];
    }else{
        self.hours.text = [NSString stringWithFormat:@"%ld小时",(long)hour];
    }
    if (minute<10) {
        self.minutes.text = [NSString stringWithFormat:@"0%ld分",(long)minute];
    }else{
        self.minutes.text = [NSString stringWithFormat:@"%ld分",(long)minute];
    }
    if (second<10) {
        self.seconds.text = [NSString stringWithFormat:@"0%ld秒",(long)second];
    }else{
        self.seconds.text = [NSString stringWithFormat:@"%ld秒",(long)second];
    }
}




//2.Btn此方法用两个NSDate对象做参数进行倒计时

-(void)startWithStartDate:(NSDate *)startDate finishDate:(NSDate *)finishDate{
    __weak __typeof(self) weakSelf = self;
    [self.countDownBtn countDownWithStratDate:startDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
//        NSLog(@"second = %li",second);
        
//            总时间
            NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        if (totoalSecond==0) {
            weakSelf.timeBtn.enabled = YES;
            [weakSelf.timeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        }else{
            weakSelf.timeBtn.enabled = NO;
            [weakSelf.timeBtn setTitle:[NSString stringWithFormat:@"%lis后重新获取",totoalSecond] forState:UIControlStateNormal];
        }
    }];
}


- (void)dealloc
{
    [self.countDownBtn destoryTimer];
    [self.countDownLabel destoryTimer];
}
@end
