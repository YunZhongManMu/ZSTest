//
//  ZSTestObj.m
//  ddd
//
//  Created by Shaun on 2019/3/28.
//  Copyright © 2019 Shaun. All rights reserved.
//

#import "ZSTestObj.h"
#import "YHBNetworkTool.h"

@implementation ZSTestObj

+ (void)testFunc {
    NSString *url = @"http://sug.music.baidu.com/info/suggestion?word=背包&version=2&from=0";
    [YHBNetworkTool GET:url parameters:nil success:^(id responseObject) {
        
        for (NSDictionary *song in responseObject[@"data"][@"song"]) {
            NSLog(@"歌名 -- %@", song[@"songname"]);
        }
        
    } failure:^(NSError *error) {
        
    } withShowView:nil];
}

@end
