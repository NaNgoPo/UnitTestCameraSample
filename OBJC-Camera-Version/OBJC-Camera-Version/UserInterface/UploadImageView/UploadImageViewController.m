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
@end

@implementation UploadImageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.mainCollectionUpdate registerNib:[UINib nibWithNibName:@"UploadingImageCell" bundle:nil] forCellWithReuseIdentifier:@"UploadingImageCell"];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UploadingImageCell" forIndexPath:indexPath];
  return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 10;
}
- (IBAction)buttonCancelDidPressed:(id)sender {
  [self dismissViewControllerAnimated:true completion:^{
    
  }];
}

@end
