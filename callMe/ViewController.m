//
//  ViewController.m
//  callMe
//
//  Created by 张岳涛 on 19/2/16.
//  Copyright © 2019年 张岳涛. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>


@interface ViewController ()

@end

@implementation ViewController
{
    NSTimer *timer;
    int timerCount;
    
    
    __weak IBOutlet UIImageView *callImageView;
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    callImageView.hidden = YES;
    
    NSString *backgroundMusic = [[NSBundle mainBundle] pathForResource:@"Default" ofType:@"mp3"];
    playAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:backgroundMusic] error:NULL];
    playAudio.numberOfLoops = -1;
    
    
}




- (IBAction)start:(id)sender {
    
    timer = [NSTimer
     scheduledTimerWithTimeInterval:1.0f
     target:self
     selector:@selector(call)
     userInfo:nil
     repeats:YES];
    
}


- (void)call {
    
    timerCount = timerCount + 1;
    
    if (timerCount >= 5) {
        
        callImageView.hidden = NO;
        
        [playAudio play];
        
    }
    
    
    
}

- (IBAction)stop:(id)sender {
    
    [timer invalidate];
    
    timerCount = 0;
    
    callImageView.hidden = YES;
    
    [playAudio stop];

}


- (void)playNotifySound {
    //获取路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Default" ofType:@"mp3"];
    //定义一个带振动的SystemSoundID
    SystemSoundID soundID = 1000;
    //判断路径是否存在
    if (path) {
        //创建一个音频文件的播放系统声音服务器
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([NSURL fileURLWithPath:path]), &soundID);
        //判断是否有错误
        if (error != kAudioServicesNoError) {
            NSLog(@"%d",(int)error);
        }
    }
    //只播放声音，没振动
    AudioServicesPlaySystemSound(soundID);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
