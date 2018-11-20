//
//  FourthViewController.m
//  CustomScrollView
//
//  Created by sama73 on 2018. 11. 20..
//  Copyright © 2018년 sama73. All rights reserved.
//

#import "FourthViewController.h"
#import "CustomScrollView.h"

@interface FourthViewController ()

// 고정 스크롤
@property (weak, nonatomic) IBOutlet CustomScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentOneHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTwoHeightConstraint;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIButton Action

- (IBAction)onExpand1Click:(UIButton *)sender {
    self.contentOneHeightConstraint.constant = 200.0f;
    
    // 슬라이더 정보 갱신
    [self.scrollView updateSliderWithIsDirect:@NO];
}

- (IBAction)onFold1Click:(UIButton *)sender {
    self.contentOneHeightConstraint.constant = 0.0f;
    
    // 슬라이더 정보 갱신
    [self.scrollView updateSliderWithIsDirect:@NO];
}

- (IBAction)onExpand2Click:(UIButton *)sender {
    self.contentTwoHeightConstraint.constant = 200.0f;
    
    // 슬라이더 정보 갱신
    [self.scrollView updateSliderWithIsDirect:@NO];
}

- (IBAction)onFold2Click:(UIButton *)sender {
    self.contentTwoHeightConstraint.constant = 0.0f;
    
    // 슬라이더 정보 갱신
    [self.scrollView updateSliderWithIsDirect:@NO];
}

@end
