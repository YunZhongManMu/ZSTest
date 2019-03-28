//
//  ViewController.m
//  PodDemo
//
//  Created by Shaun on 2019/3/28.
//  Copyright © 2019 Shaun. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 原项目请求
- (IBAction)buttonClick1:(id)sender {
    
    // AFN -version 2.1.0
    
     NSString *url = @"http://sug.music.baidu.com/info/suggestion?word=背包&version=2&from=0";
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *mananger = [AFHTTPSessionManager manager];
    [mananger GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        for (NSDictionary *song in responseObject[@"data"][@"song"]) {
            NSLog(@"原项目 - 歌名 -- %@", song[@"songname"]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (IBAction)buttonClick2:(id)sender {
    
    // pod ZSTest AFN -version 3.2.1
    
}

@end
