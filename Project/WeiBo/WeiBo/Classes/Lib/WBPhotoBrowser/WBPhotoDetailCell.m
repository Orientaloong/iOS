//
//  WBPhotoDetailCell.m
//  WeiBo
//
//  Created by wbs on 17/2/24.
//  Copyright © 2017年 xiaomaolv. All rights reserved.
//

#import "WBPhotoDetailCell.h"
#import "WBPhoto.h"

#define kMaxZoomScale 2.5f
#define kMinZoomScale 1.0f

@interface WBPhotoDetailCell ()<UIScrollViewDelegate>

@end

@implementation WBPhotoDetailCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.maximumZoomScale = kMaxZoomScale;
        scrollView.minimumZoomScale = kMinZoomScale;
        scrollView.decelerationRate = 0.5;
        scrollView.delegate = self;
        [self.contentView addSubview:scrollView];
        _scrollView = scrollView;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.clipsToBounds = YES;
        [self.scrollView addSubview:imageView];
        _imageView = imageView;
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
        [self addGestureRecognizer:singleTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

- (void)doubleTap
{
    CGFloat zoomScale = self.scrollView.zoomScale;
    if (zoomScale == kMaxZoomScale) {
        zoomScale = kMinZoomScale;
    } else {
        zoomScale = kMaxZoomScale;
    }
    [self.scrollView setZoomScale:zoomScale animated:YES];
}

- (void)singleTap
{
    if ([self.delegate respondsToSelector:@selector(photoDetailCellDidSingleTap:)]) {
        [self.delegate photoDetailCellDidSingleTap:self];
    }
}

- (void)setPhoto:(WBPhoto *)photo
{
    _photo = photo;
    
    self.scrollView.zoomScale = kMinZoomScale;
    
    [self setupSubviewWithImage:photo.srcView.image];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:photo.remoteUrlString] placeholderImage:photo.srcView.image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self setupSubviewWithImage:image];
    }];
}

#pragma mark - Private

- (void)setupSubviewWithImage:(UIImage *)image
{
    if (!image) return;
    CGSize imageSize = image.size;
    CGFloat h = imageSize.height / imageSize.width * self.scrollView.bounds.size.width;
    if (h >= self.scrollView.bounds.size.height) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, h);
        self.imageView.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, h);
    } else {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        self.imageView.frame = CGRectMake(0, (self.scrollView.bounds.size.height - h) * 0.5, self.scrollView.bounds.size.width, h);
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;

    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
}

@end
