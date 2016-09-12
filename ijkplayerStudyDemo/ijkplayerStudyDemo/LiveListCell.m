//
//  LiveListCell.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/9.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "LiveListCell.h"
#import "UIView+RoundedCorner.h"
#import "UIColor+HexString.h"
#import <SDAutoLayout.h>
#import "LiveModel.h"
#import "CreatorModel.h"
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>

static CGFloat const headerImageTopOffset = 10.0f;
static CGFloat const headerImageLeftOffset = 10.0f;
static CGFloat const headerImageSize = 40.0f;
static CGFloat const nickLabelTopOffset = 13.0f;
static CGFloat const nickLabelLeftOffset = 9.0f;
static CGFloat const cityButtonTopOffset = 4.0f;
static CGFloat const cityButtonRiggtOffset = 20.0f;
static CGFloat const onlineUserLabelRightOffset = 10.0f;
static CGFloat const watchingLabelTopOffset = 4.0f;
static CGFloat const showImageViewTopOffset = 10.0f;
static CGFloat const showImageViewHeight = 363.0f;
static CGFloat const liveLabelTopOffset = 10.0f;
static CGFloat const liveLabelRightOffset = 10.0f;
static CGFloat const liveLabelWidth = 62.0f;
static CGFloat const liveLabelHeight = 20.0f;
static CGFloat const nameLabelOffset = 10.0f;
static CGFloat const footerSeparaterViewHeight = 7.0f;

static NSString * const imageURLString = @"http://img.meelive.cn/";

@interface LiveListCell()

@property (nonatomic, strong) UIButton *headerImageButton;

@property (nonatomic, strong) UILabel *nickLabel;

@property (nonatomic, strong) UIButton *cityButton;

@property (nonatomic, strong) UILabel *onlinUsersLabel;

@property (nonatomic, strong) UILabel *watchingLabel;

@property (nonatomic, strong) UIImageView *showImageView;

@property (nonatomic, strong) UILabel *liveLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *footerSeparaterView;

@end

@implementation LiveListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatViews];
        [self installConstraints];
    }
    return self;
}

- (void)creatViews {
    _headerImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_headerImageButton];
    
    _nickLabel = [[UILabel alloc] init];
    _nickLabel.font = [UIFont systemFontOfSize:15.0f];
    _nickLabel.textColor = [UIColor hexString:@"849195"];
    [self.contentView addSubview:_nickLabel];
    
    _cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityButton.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    _cityButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _cityButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [_cityButton setTitleColor:[UIColor hexString:@"9da9ad"] forState:UIControlStateNormal];
    [self.contentView addSubview:_cityButton];

    
    _onlinUsersLabel = [[UILabel alloc] init];
    _onlinUsersLabel.font = [UIFont systemFontOfSize:15.0f];
    _onlinUsersLabel.textColor = [UIColor hexString:@"ff9116"];
    [self.contentView addSubview:_onlinUsersLabel];
    
    _watchingLabel = [[UILabel alloc] init];
    _watchingLabel.text = @"在看";
    _watchingLabel.font = [UIFont systemFontOfSize:11.0f];
    _watchingLabel.textColor = [UIColor hexString:@"9fabaf"];
    [self.contentView addSubview:_watchingLabel];
    
    _footerSeparaterView = [[UIView alloc] init];
    _footerSeparaterView.backgroundColor = [UIColor hexString:@"f0f7f6"];
    [self.contentView addSubview:_footerSeparaterView];
    
    _showImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_showImageView];
    
    _liveLabel = [[UILabel alloc] init];
    _liveLabel.backgroundColor = [UIColor clearColor];
    _liveLabel.text = @"直播";
    _liveLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    _liveLabel.textAlignment = NSTextAlignmentCenter;
    _liveLabel.textColor = [UIColor whiteColor];
    _liveLabel.layer.borderWidth = 1.0f;
    _liveLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _liveLabel.layer.masksToBounds = YES;
    _liveLabel.layer.cornerRadius = 10.0f;
    [_showImageView addSubview:_liveLabel];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.backgroundColor = [UIColor whiteColor];
    _nameLabel.textColor = [UIColor hexString:@"596569"];
    _nameLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_nameLabel];
}

- (void)installConstraints {
    _headerImageButton.sd_layout
    .topSpaceToView(self.contentView, headerImageTopOffset)
    .leftSpaceToView(self.contentView, headerImageLeftOffset)
    .heightIs(headerImageSize)
    .widthIs(headerImageSize);
    [_headerImageButton setRoundedCorner];
    
    _nickLabel.sd_layout
    .topSpaceToView(self.contentView, nickLabelTopOffset)
    .leftSpaceToView(_headerImageButton, nickLabelLeftOffset)
    .autoHeightRatio(0);
    [_nickLabel setSingleLineAutoResizeWithMaxWidth:CGFLOAT_MAX];
    
    _onlinUsersLabel.sd_layout
    .topEqualToView(_nickLabel)
    .rightSpaceToView(self.contentView, onlineUserLabelRightOffset)
    .autoHeightRatio(0);
    [_onlinUsersLabel setSingleLineAutoResizeWithMaxWidth:CGFLOAT_MAX];
    
    _watchingLabel.sd_layout
    .topSpaceToView(_onlinUsersLabel, watchingLabelTopOffset)
    .rightEqualToView(_onlinUsersLabel)
    .autoHeightRatio(0);
    [_watchingLabel setSingleLineAutoResizeWithMaxWidth:CGFLOAT_MAX];
    
    _cityButton.sd_layout
    .topSpaceToView(_nickLabel, cityButtonTopOffset)
    .leftEqualToView(_nickLabel)
    .rightSpaceToView(_watchingLabel, cityButtonRiggtOffset);

    _showImageView.sd_layout
    .topSpaceToView(_headerImageButton, showImageViewTopOffset)
    .widthIs([UIScreen mainScreen].bounds.size.width)
    .heightIs(showImageViewHeight);
    
    _liveLabel.sd_layout
    .topSpaceToView(_showImageView, liveLabelTopOffset)
    .rightSpaceToView(_showImageView, liveLabelRightOffset)
    .widthIs(liveLabelWidth)
    .heightIs(liveLabelHeight);
    
    _nameLabel.sd_layout
    .topSpaceToView(_showImageView, 0)
    .heightIs(0)
    .leftSpaceToView(self.contentView, nameLabelOffset)
    .rightSpaceToView(self.contentView, nameLabelOffset);
    
    _footerSeparaterView.sd_layout
    .topSpaceToView(_nameLabel, 0)
    .heightIs(footerSeparaterViewHeight)
    .widthRatioToView(_showImageView, 1.0);
}

- (void)setLive:(LiveModel *)live {
    if (_live != live) {
        _live = nil;
        _live = live;

        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageURLString,live.creator.portrait]];
        [_headerImageButton sd_setImageWithURL:url forState:UIControlStateNormal];
        _nickLabel.text = live.creator.nick;
        if (live.city.length > 0) {
            [_cityButton setTitle:live.city forState:UIControlStateNormal];
        } else {
            [_cityButton setTitle:@"难道在火星？" forState:UIControlStateNormal];
        }
        _onlinUsersLabel.text = [NSString stringWithFormat:@"%lu",live.online_users];
        [_showImageView sd_setImageWithURL:url];
        if (live.name.length > 0) {
            _nameLabel.sd_layout.heightIs(40);
            _nameLabel.text = live.name;
        }
        // 高度自适应cell设置步骤1
        [self setupAutoHeightWithBottomView:_footerSeparaterView bottomMargin:0];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    _nameLabel.sd_layout.heightIs(0);
}

@end
