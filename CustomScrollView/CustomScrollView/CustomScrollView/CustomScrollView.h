//
//  CustomScrollView.h
//  Asiana
//
//  Created by sama73 on 2018. 11. 14..
//  Copyright © 2018년 sama73. All rights reserved.
//
/** 스크롤뷰 스크롤바를 활성화 시킨다.
 * 스크롤뷰의 컨텐츠뷰 영역정보가 변경되는 시점에 updateSlider를 호출해줍니다.
 * 슬라이더 정보를 바로 갱신해준다.
 * [self.scrollView updateSliderWithIsDirect:@YES];
 *
 * 슬라이더 정보를 0.1초후에 갱신해준다.
 * [self.scrollView updateSliderWithIsDirect:@NO];
 */

#import <UIKit/UIKit.h>

@interface CustomScrollView : UIScrollView

/** 슬라이더 정보 갱신
 * isDirect 값이 @YES 일때는 딜레이 없이 슬라이더 영역을 바로 처리해 준다.
 * isDirect 값이 @NO 일때는 0.15초 딜레이 후 슬라이더 영역을 처리해 준다.
 */
- (void)updateSliderWithIsDirect:(NSNumber *)isDirect;

@end
