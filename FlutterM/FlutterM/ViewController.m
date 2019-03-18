//
//  ViewController.m
//  FlutterM
//
//  Created by ZhangXiaosong on 2019/3/5.
//  Copyright © 2019 ZhanXiaosong. All rights reserved.
//

#import "ViewController.h"
#import "ViewTTViewController.h"
#import <Flutter/Flutter.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn setTitle:@"NEXT" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 100, 50)];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)click
{
//    ViewTTViewController *viewCon = [[ViewTTViewController alloc] init];
//    [self.navigationController pushViewController:viewCon animated:YES];
    
//    FlutterViewController *viewController = [[FlutterViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
    
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    
    flutterViewController.navigationItem.title= @"Flutter Demo";
//    __weak__typeof(self) weakSelf = self;
    // 要与main.dart中一致
    NSString *channelName = @"com.pages.your/native_get";
    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:flutterViewController];
    
    [messageChannel setMethodCallHandler:^(FlutterMethodCall* _Nonnullcall, FlutterResult  _Nonnullresult) {
        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
        // result 是给flutter的回调， 该回调只能使用一次
        NSLog(@"flutter 给到我：\nmethod=%@ \narguments = %@",_Nonnullcall.method,_Nonnullcall.arguments);
        if([_Nonnullcall.method isEqualToString:@"toNativeSomething"]) {
            UIAlertView*alertView = [[UIAlertView alloc] initWithTitle:@"flutter回调" message:[NSString stringWithFormat:@"%@",_Nonnullcall.arguments] delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
            [alertView show];
            // 回调给flutter
            if(_Nonnullresult) {
                _Nonnullresult(@10);
            }
        } else if([_Nonnullcall.method isEqualToString:@"toNativePush"]) {
            //            ThirdViewController *testVC = [[ThirdViewController alloc] init];
            //            testVC.parames = call.arguments;
            //            [weakSelf.navigationController pushViewController:testVC animated:YES];
        } else if([_Nonnullcall.method isEqualToString:@"toNativePop"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
        [self.navigationController pushViewController:flutterViewController animated:YES];
//    [self presentViewController:flutterViewController animated:YES completion:nil];
    
    
}


@end
