//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
 
        File name:     KLProgressHUD.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
 
        Description:
 
        History:
                2018/6/29: File created.
 
 ********************************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  获取相机权限成功
 *
 *  @param imagePickerController 获取相机权限成功
 */
typedef void(^CameraSuccess)(UIImagePickerController * imagePickerController);

/**
 *  获取相机权限失败
 */
typedef void(^CameraFail)(UIImagePickerController * imagePickerController);

/**
 *  获取相簿权限成功
 *
 *  @param imagePickerController 获取相簿权限失败
 */
typedef void(^AlbumSuccess)(UIImagePickerController * imagePickerController);

/**
 *  获取相簿权限失败
 */
typedef void(^AlbumFail)(UIImagePickerController * imagePickerController);

/**
 *  获取图片 代理
 */
@protocol KLImagePickerControllerDelegate <NSObject>
@optional

/**
 *  不缓存状态下的图片回调
 *
 *  @param image 回调的图片
 */
- (void)kl_selectImageFinished:(UIImage * )image;

/**
 *  缓存状态下的图片回调
 *
 *  @param image      回调的图片
 *  @param identifier 图片的标识符(缓存的文件名称)
 *  @param isCaches   缓存是否成功
 */
- (void)kl_selectImageFinishedAndCaches:(UIImage * )image cachesIdentifier:(NSString *)identifier isCachesSuccess:(BOOL)isCaches;

@end

@interface KLImagePickerController : NSObject
/**
 *  设置是否缓存 默认为NO
 */

@property (nonatomic,assign) BOOL isCaches;

/**
 *  设置是否编辑图片，默认为YES.设置为NO时，选择图片的时候不出现裁剪框，返回图片尺寸大小正常。
 */
@property (nonatomic,assign) BOOL isEditImage;

/**
 *  设置缓存标识符(缓存的文件名称)
 */
@property (nonatomic,strong) NSString * identifier;

/**
 *  选取图片结束的代理
 */
@property (nonatomic,weak) id<KLImagePickerControllerDelegate>delegate;

/**
 *  需要缓存时的初始化方法
 *
 *  @param isCaches   设置缓存状态 默认为NO
 *  @param identifier 设置缓存标识符
 *
 *  @return 需要缓存时的初始化方法
 */
- (instancetype)initWithIsCaches:(BOOL)isCaches andIdentifier:(NSString *)identifier;

/**
 *  选取来自相机的图片
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)kl_selectImageFromCameraSuccess:(CameraSuccess)success fail:(CameraFail)failure;

/**
 *  选取来自相簿的图片
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)kl_selectImageFromAlbumSuccess:(AlbumSuccess)success fail:(AlbumFail)failure;

/**
 *  读取缓存的图片
 *
 *  @param identifier 缓存标识符
 *
 *  @return 缓存的图片
 */
- (UIImage *)kl_readImageFromCachesIdentifier:(NSString *)identifier;

/**
 *  删除指定的缓存的图片
 *
 *  @param identifier 缓存标识符
 *
 *  @return 是否删除成功
 */
- (BOOL)kl_removeCachePictureForIdentifier:(NSString *)identifier;

/**
 *  删除全部缓存的图片
 *
 *  @return 是否删除成功
 */
- (BOOL)kl_removeCachePictures;




@end
