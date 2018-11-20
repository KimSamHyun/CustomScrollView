//
//  FifthViewController.m
//  CustomScrollView
//
//  Created by sama73 on 2018. 11. 20..
//  Copyright © 2018년 sama73. All rights reserved.
//

#import "FifthViewController.h"
#import "CustomScrollView.h"

@interface FifthViewController ()

// 고정 스크롤
@property (weak, nonatomic) IBOutlet CustomScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbMessage;
@property (weak, nonatomic) IBOutlet UILabel *lbArrow;

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.lbMessage setAlpha:0.0f];
    [self.lbArrow setAlpha:0.0f];
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

// 메세지 알파 처리
- (void)updateMessageAlpha {
    CGRect frame = self.scrollView.frame;
    CGSize contentSize = self.scrollView.contentSize;
    if (contentSize.height <= frame.size.height) {
        return;
    }
    
    // 이동 가능 거리
    CGFloat moveDistance = contentSize.height - frame.size.height;
    CGFloat moveScale = self.scrollView.contentOffset.y / moveDistance;
    if (moveScale < 0.0f) {
        moveScale = 0.0f;
    }
    else if (moveScale > 1.0f) {
        moveScale = 1.0f;
    }
    
    // 스크롤 거리에 따라서 레이블의 알파값을 적용 시킨다.
    [self.lbMessage setAlpha:moveScale];
    [self.lbArrow setAlpha:moveScale];
}

#pragma mark - UIScrollViewDelegate

// 2. 스크롤뷰가 스크롤 된 후에 실행된다.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll:");
    
    if (scrollView == self.scrollView) {
        // 슬라이더 정보 갱신
        [self.scrollView updateSliderWithIsDirect:@YES];
        
        // 메세지 알파 처리
        [self updateMessageAlpha];
    }
}

// 드래그가 스크롤 뷰에서 끝났을 때 대리자에게 알립니다.
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging:willDecelerate:");
    
    if (scrollView == self.scrollView) {
        // 슬라이더 정보 갱신
        [self.scrollView updateSliderWithIsDirect:@YES];
        
        // 메세지 알파 처리
        [self updateMessageAlpha];
    }
}

// 스크롤 애니메이션의 감속 효과가 종료된 후에 실행된다.
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    
    if (scrollView == self.scrollView) {
        // 슬라이더 정보 갱신
        [self.scrollView updateSliderWithIsDirect:@YES];
        
        // 메세지 알파 처리
        [self updateMessageAlpha];
    }
}

@end
