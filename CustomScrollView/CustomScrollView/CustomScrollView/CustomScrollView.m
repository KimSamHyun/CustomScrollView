//
//  CustomScrollView.m
//  Asiana
//
//  Created by sama73 on 2018. 11. 14..
//  Copyright © 2018년 sama73. All rights reserved.
//

#import "CustomScrollView.h"

// RGB HEX color 매크로
#define UIColorFromHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

// 슬라이더 폭
#define SLIDER_WIDTH    2.5f
// 슬라이더 갭
#define SLIDER_GAP      3.0f

@interface CustomScrollView()<UIScrollViewDelegate> {
    // 이전 스크롤뷰 높이
    CGFloat oldScrollViewHeight;
    // 이전 컨텐츠 높이
    CGFloat oldContentHeight;
    // 슬라이더 영역
    CGRect frameSlider;
    // 이동할 위치 스케일값
    CGFloat oldScaleMove;
    // 슬라이더 뷰
    UIView *vSlider;
    
    // Thumb 영역
    CGRect frameThumb;
    // Thumb 뷰
    UIView *vThumb;
}

@end

@implementation CustomScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    
    // UIScrollViewDelegate
    self.delegate = self;
    
    // 슬라이더를 비활성화 시켜준다.
    [self setShowsVerticalScrollIndicator:NO];
    
    // init
    frameSlider = CGRectZero;
    frameThumb = CGRectZero;
    oldScrollViewHeight = 0;
    oldContentHeight = 0;
    oldScaleMove = 0.0f;
    
    
    // 슬라이더용 뷰를 생성후 추가시켜 줍니다.
    vSlider = [UIView new];
    vSlider.layer.cornerRadius = 1;
    vSlider.backgroundColor = [UIColor clearColor];
    [vSlider setClipsToBounds:YES];
    
    vThumb = [UIView new];
    vThumb.layer.cornerRadius = 1;
    vThumb.backgroundColor = UIColorFromHEX(0xD60815);
    [vSlider addSubview:vThumb];
    [self addSubview:vSlider];
    
    // 슬라이더 정보 갱신
    [self updateSliderWithIsDirect:@NO];
}

// 슬라이더 정보 갱신
- (void)updateSliderWithIsDirect:(NSNumber *)isDirect {
    
    // isDirect값이 @NO일경우 0.15초 딜레이 후 재실행 시켜준다.
    if ([isDirect boolValue] == NO) {
        // 스케쥴
        [self performSelector:@selector(updateSliderWithIsDirect:) withObject:@YES afterDelay:0.15f];
        
        return;
    }
    
    CGSize sizeContent = self.contentSize;
    CGRect frameScrollView = self.frame;
    
    if (sizeContent.height == 0) {
        return;
    }
    
    // 컨텐츠 영역이 변경되었으면 슬라이더 정보를 갱신해준다.
    if (oldScrollViewHeight != frameScrollView.size.height || oldContentHeight != sizeContent.height) {
        oldScrollViewHeight = frameScrollView.size.height;
        oldContentHeight = sizeContent.height;
        
        // 스크롤 높이가 컨텐츠 높이 보다 높을 경우 슬라이더를 숨겨준다.
        if (oldScrollViewHeight >= oldContentHeight) {
            [vSlider setHidden:YES];
            return;
        }
        
        [vSlider setHidden:NO];

        // 슬라이더 영역 설정
        // scrollView width - gap(3) - Indictors width(SLIDER_WIDTH)
        CGFloat posX = frameScrollView.size.width - 3 - SLIDER_WIDTH;
        frameSlider = CGRectMake(posX, 0, SLIDER_WIDTH, oldScrollViewHeight - (SLIDER_GAP * 2));

        // Thumb 영역 설정
        // Thumb 높이 스케일
        CGFloat scaleThumb = frameSlider.size.height / oldContentHeight;

        // 슬라이더 높이
        CGFloat heightThumb = round(frameSlider.size.height * scaleThumb);
        // 이동할 위치 스케일값(슬라이더 이동가능 높이) / (컨텐츠 이동가능 높이)
        oldScaleMove = (frameSlider.size.height - heightThumb) / (oldContentHeight - oldScrollViewHeight);
        
        frameThumb = CGRectMake(0, 0, SLIDER_GAP, heightThumb);
    }
    
    // 슬라이더 영역 offset 설정
    frameSlider.origin.y = self.contentOffset.y + SLIDER_GAP;
    [vSlider setFrame:frameSlider];
    
    // Thumb 영역 offset 설정
    frameThumb.origin.y = self.contentOffset.y * oldScaleMove;
    [vThumb setFrame:frameThumb];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


#pragma mark - UIScrollViewDelegate
// 스크롤 뷰에서 내용 스크롤을 시작할 시점을 대리인에게 알립니다.
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging:");
    
}

// 2. 스크롤뷰가 스크롤 된 후에 실행된다.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll:");
    
    // 슬라이더 정보 갱신
    [self updateSliderWithIsDirect:@YES];
}

// 드래그가 스크롤 뷰에서 끝났을 때 대리자에게 알립니다.
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging:willDecelerate:");
    
    // 슬라이더 정보 갱신
    [self updateSliderWithIsDirect:@YES];
}

// (현재 못씀)
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
    
}

// 스크롤뷰가 Touch-up 이벤트를 받아 스크롤 속도가 줄어들때 실행된다.
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDecelerating");
    
}

// 스크롤 애니메이션의 감속 효과가 종료된 후에 실행된다.
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    
    // 슬라이더 정보 갱신
    [self updateSliderWithIsDirect:@YES];
}

// scrollView.scrollsToTop = YES 설정이 되어 있어야 아래 이벤트를 받을수 있다.
// 스크롤뷰가 가장 위쪽으로 스크롤 되기 전에 실행된다. NO를 리턴할 경우 위쪽으로 스크롤되지 않도록 한다.
//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
//{
//    NSLog(@"scrollViewShouldScrollToTop");
//    return YES;
//}

// 스크롤뷰가 가장 위쪽으로 스크롤 된 후에 실행된다.
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
//{
//    NSLog(@"scrollViewDidScrollToTop");
//}

// 사용자가 콘텐츠 스크롤을 마쳤을 때 대리인에게 알립니다.
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"scrollViewWillEndDragging:withVelocity:targetContentOffset:");
    
}

@end
