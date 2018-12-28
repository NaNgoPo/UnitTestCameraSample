//
//  UploadImageViewController.m
//  OBJC-Camera-Version
//
//  Created by East Agile on 12/24/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

#import "UploadImageViewController.h"

@interface UploadImageViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionUpdate;
@property (strong,nonatomic) UploadingImageController *controller;
@property (strong,nonatomic) PHFetchResult<PHAsset *> *result;
@property (strong,nonatomic) NSMutableArray *selectedList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraitTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraitHeight;
@property (weak, nonatomic) IBOutlet UIView *carouselHolder;
@property (weak, nonatomic) IBOutlet UILabel *labelPostItem;
@property (weak, nonatomic) IBOutlet UIView *indicatedView;
@property (weak, nonatomic) IBOutlet UIView *mainViewHolder;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIButton *buttonChooseGallery;

@property (strong,nonatomic) CarouselView *carousel;
@property (assign,nonatomic) double firstX;
@property (assign,nonatomic) double firstY;
@end

@implementation UploadImageViewController
const double PADDING_FRAME = 64.0;
const double MAX_VAL = 0.6;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.mainCollectionUpdate registerNib:[UINib nibWithNibName:@"UploadingImageCell" bundle:nil] forCellWithReuseIdentifier:@"UploadingImageCell"];
  self.controller = [UploadingImageController new];
  self.carousel = [CarouselView new];
  [self.carouselHolder addSubview:self.carousel.view];
  self.firstX = 0.0;
  self.firstY = 0.0;
  [self setUpGesture];
  [self addObserver:self.mainViewHolder forKeyPath:@"center" options:NSKeyValueObservingOptionOld context:NULL];
  @weakify(self);
  [self.controller.eventLoadImage subscribeNext:^(id  _Nullable loadImagesEvent) {
    @strongify(self);
    self.result = (PHFetchResult<PHAsset *> *)loadImagesEvent;
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.mainCollectionUpdate reloadData];
    });
  }];
  [self.controller.eventSelected subscribeNext:^(id  _Nullable listOfSelectedItem) {
    @strongify(self);
    self.selectedList = (NSMutableArray *)listOfSelectedItem;
    dispatch_async(dispatch_get_main_queue(), ^(void){
      NSArray<NSIndexPath *> *visibleCells = [self.mainCollectionUpdate indexPathsForVisibleItems];
      [self.mainCollectionUpdate reloadItemsAtIndexPaths:visibleCells];
      [self setTextFotCountLabel];
      NSMutableArray * selectedItems = [NSMutableArray new];
      
      [self.carousel changeDisplay:self.result fromInfo:self.selectedList];
    });
  }];
  [self setTextFotCountLabel];
}
- (void)setUpGesture{
  UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragGesture:)];
  [panRecognizer setMinimumNumberOfTouches:1];
  [panRecognizer setMaximumNumberOfTouches:1];
  [self.mainViewHolder addGestureRecognizer:panRecognizer];
  
  UISwipeGestureRecognizer *mSwipeUpRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDetection)];
  [mSwipeUpRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
  [self.view addGestureRecognizer:mSwipeUpRecognizer];
}
-(void)swipeDetection{
  [self dismissViewControllerAnimated:true completion:^{
    // do nothing.....
  }];
}
-(void)dragGesture:(UIPanGestureRecognizer*)sender {
  
  [self.view bringSubviewToFront:sender.view];
  CGPoint translatedPoint = [sender translationInView:sender.view.superview];
  
  if (sender.state == UIGestureRecognizerStateBegan) {
    self.firstX = self.backGroundView.frame.size.width/2.0;//sender.view.center.x;
    self.firstY = sender.view.center.y;
  }
  translatedPoint = CGPointMake(sender.view.center.x, sender.view.center.y+translatedPoint.y);
  
  [sender.view setCenter:translatedPoint];
  [sender setTranslation:CGPointZero inView:sender.view];
  
  if (sender.state == UIGestureRecognizerStateEnded) {
    CGFloat finalY = translatedPoint.y ;// translatedPoint.y + (.35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
    CGFloat correctY = finalY - self.backGroundView.frame.size.height / 2.0;
    if (correctY > self.view.frame.size.height/2) { // to avoid status bar
      [self correctColor:0.0];
      [self dismissViewControllerAnimated:true completion:^{
        // do nothing.....
      }];
    } else {
      finalY = PADDING_FRAME;
      [UIView animateWithDuration:0.2 animations:^{
         [sender.view setCenter:CGPointMake(sender.view.center.x,  self.backGroundView.frame.size.height / 2.0 + finalY)];
      }];
    }
  }
  [self calculatedAndHightLightView];
}
- (void)viewDidLayoutSubviews{
  self.carousel.view.frame = CGRectMake(0, 0, self.carouselHolder.frame.size.width, self.carouselHolder.frame.size.height);
 
  self.constraitHeight.constant = self.backGroundView.frame.size.height - PADDING_FRAME;
  
}
-(void)setTextFotCountLabel{
  int validSlotCouting = [self.controller getCountValidItem];
  if(validSlotCouting == 0){
    [self.labelPostItem setHidden:true];
    [self.indicatedView setHidden:true];
  }else{
    [self.labelPostItem setHidden:false];
    [self.indicatedView setHidden:false];
    [self.labelPostItem setText:[NSString stringWithFormat:@"Post(%d)",validSlotCouting]];
  }
}
-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self calculatedAndHightLightView];
  [self.controller getAllItemInDevicePhotos];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  PHAsset *asset = [self.result objectAtIndex:indexPath.row];
  UploadingImageCell *cell = (UploadingImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UploadingImageCell" forIndexPath:indexPath];
  BOOL isSelected = [self.controller isSelectedItemAt:(int)indexPath.row];
  [cell setupUploadingCell:asset withHighLight:isSelected];
  return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  [self.controller selectAssetAtIndex:(int)indexPath.row andList:self.result];
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.result.count;
}
- (IBAction)buttonCancelDidPressed:(id)sender {
  [self correctColor:0.0];
  [self dismissViewControllerAnimated:true completion:^{
    
  }];
}
- (IBAction)buttonChooseGalleryDidPressed:(id)sender {
  [self performSegueWithIdentifier:@"showGallery" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if([segue.identifier isEqualToString:@"showGallery"]){
    GalleryChoosenView *galleryView = (GalleryChoosenView *)[segue destinationViewController];
    galleryView.eventChoosenGallery = [RACSubject new];
    [self listenChangingAlbum:galleryView.eventChoosenGallery];
  }
}

#pragma mar - Util methods
- (void)listenChangingAlbum:(RACSubject *)event{
  @weakify(self);
  [event subscribeNext:^(id  _Nullable album) {
    @strongify(self);
    if([album isKindOfClass:[PHAssetCollection class]]){
      PHAssetCollection *concreteAlbum = (PHAssetCollection *)album;
      [self.controller getAllItemInsideAlbum:album];
      [self.buttonChooseGallery setTitle:concreteAlbum.localizedTitle forState:(UIControlStateNormal)];
    }
  }];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  CGSize sizeView = collectionView.frame.size;
  double  newWidth = sizeView.width / 5;
  double newHeight = sizeView.height / 2;
  return CGSizeMake(newWidth, newHeight);
}
- (void)calculatedAndHightLightView{
  double frameValue = self.mainViewHolder.frame.origin.y ;
  double screenMAxValue = self.backGroundView.frame.size.height;
  double percentage = (screenMAxValue - frameValue )/screenMAxValue;
   NSLog(@"value %f and %f", percentage,screenMAxValue);
  [self correctColor:percentage];
}
-(void)correctColor:(double)percentage{
  double formattedPercentage = fabs(percentage);
  if(formattedPercentage >= 0.6){
    formattedPercentage = 0.6;
  }
  UIColor *backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:formattedPercentage];
  self.view.backgroundColor = backgroundColor;
}


@end
