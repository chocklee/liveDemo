//
//  ViewController.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/8/22.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "ViewController.h"
#import "LiveViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(UIButton *)sender {
    LiveViewController *lvc = [[LiveViewController alloc] init];
    [self.navigationController showViewController:lvc sender:nil];
}

@end
