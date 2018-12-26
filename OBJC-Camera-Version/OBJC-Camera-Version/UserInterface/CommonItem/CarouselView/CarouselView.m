//
//  CarouselView.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/26/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "CarouselView.h"

@interface CarouselView ()
@property (weak, nonatomic) IBOutlet iCarousel *carouselMain;
@end

@implementation CarouselView
const int TAG_VIEW = 10;
- (void)viewDidLoad {
  [super viewDidLoad];
  self.listOfAsset = [NSMutableArray new];
  self.carouselMain.type = iCarouselTypeRotary;
  // Do any additional setup after loading the view from its nib.
}

-(void)changeDisplay:(PHFetchResult<PHAsset *> *)assets fromInfo:(NSMutableArray *)selectedList{
  [self.listOfAsset removeAllObjects];
  for (int i = 0; i<selectedList.count; i++) {
    if([selectedList[i] integerValue] != INVALID_VALUE){
      PHAsset * value = [assets objectAtIndex:[selectedList[i] integerValue]];
      [self.listOfAsset addObject:value];
    }
    dispatch_async(dispatch_get_main_queue(), ^(void){
      [self.carouselMain reloadData];
    });
  }
}
- (nonnull UIView *)carousel:(nonnull iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
  if(view != nil){
    UIImageView *viewImage = (UIImageView *)[view viewWithTag:TAG_VIEW];
    [self setInfoFor:viewImage withAsset:[self.listOfAsset objectAtIndex:index]];
    return view;
  }else{
    UIView *displayedView = [[UIView alloc] initWithFrame:self.view.frame];
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.frame];
    image.tag = TAG_VIEW;
    [displayedView addSubview:image];
    [self setInfoFor:image withAsset:[self.listOfAsset objectAtIndex:index]];
    return displayedView;
  }
}
- (void)setInfoFor:(UIImageView *)imageView withAsset:(PHAsset *)asset{
  @weakify(self);
  [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageView.frame.size contentMode:(PHImageContentModeDefault) options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
    //    @strongify(self);
    dispatch_async(dispatch_get_main_queue(), ^(void){
      imageView.image = result;
    });
  }];
}
- (NSInteger)numberOfItemsInCarousel:(nonnull iCarousel *)carousel {
  return self.listOfAsset.count;
}



@end
