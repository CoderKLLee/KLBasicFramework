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

#import "KLImagePickerController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface KLImagePickerController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImagePickerController * imagePickerController;

@property (nonatomic,strong) UIImage * image;

@end

//是否采用裁剪后的图片
static BOOL kl_isEditImage = YES;


@implementation KLImagePickerController
- (void)setIsEditImage:(BOOL)isEditImage{
    kl_isEditImage = isEditImage;
}

#pragma mark - 初始化方法
- (instancetype)initWithIsCaches:(BOOL)isCaches andIdentifier:(NSString *)identifier{
    self = [super init];
    if (self) {
        self.isCaches = isCaches;
        self.identifier = identifier;
    }
    return self;
}

#pragma mark - 来自相机
- (void)kl_selectImageFromCameraSuccess:(CameraSuccess)success fail:(CameraFail)failure{
    if (failure) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
            failure(self.imagePickerController);
            return;
        }
    }
    if (success) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
            self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            success(self.imagePickerController);
        }
    }
}

#pragma mark - 来自相簿
- (void)kl_selectImageFromAlbumSuccess:(AlbumSuccess)success fail:(AlbumFail)failure{
    if (failure) {

        //----第一次不会进来
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
            // 无权限 做一个友好的提示
            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许该应用访问您的相机\n设置>隐私>相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alart show];
            return;
        }
        
        //----每次都会走进来
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                NSLog(@"Authorized");
            }else{
            //----为什么没有在这个里面进行权限判断，因为会项目会蹦。。。
            failure(self.imagePickerController);
            return;
       
            }
        }];
        
//        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
//        if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
//            failure(self.imagePickerController);
//            return;
//        }
    }
    if (success) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        success(self.imagePickerController);
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString * mediaType = info[UIImagePickerControllerMediaType];

    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        if (kl_isEditImage) {
            self.image = info[UIImagePickerControllerEditedImage];
        }else {
            self.image = info[UIImagePickerControllerOriginalImage];
        }
        NSString * url = info[UIImagePickerControllerMediaURL];
        NSLog(@"uuu:%@",url);
        if (self.isCaches == true && self.identifier != nil && ![self.identifier  isEqual: @""]) {
            if ([self.delegate respondsToSelector:@selector(kl_selectImageFinishedAndCaches:cachesIdentifier:isCachesSuccess:)]) {
                BOOL cachesStatus = [self saveImageToCaches:self.image
                                                 identifier:self.identifier];
                [self.delegate kl_selectImageFinishedAndCaches:self.image
                                           cachesIdentifier:self.identifier
                                            isCachesSuccess:cachesStatus];
            }
        }
        else if ([self.delegate respondsToSelector:@selector(kl_selectImageFinished:)]) {
            [self.delegate kl_selectImageFinished:self.image];
        }
    }
}

#pragma mark - 读取缓存的图片
- (UIImage *)kl_readImageFromCachesIdentifier:(NSString *)identifier {
    NSString * path = [NSString stringWithFormat:@"%@/%@",cachesPath(),identifier];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData * imgeData = [[NSFileManager defaultManager] contentsAtPath:path];
        if (imgeData) {
            UIImage * image = [[UIImage alloc]initWithData:imgeData];
            return image;
        }
    }
    return nil;
}

#pragma mark - 删除指定缓存的图片
- (BOOL)kl_removeCachePictureForIdentifier:(NSString *)identifier {
    NSString * path = [NSString stringWithFormat:@"%@/%@",cachesPath(),identifier];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        NSError * error ;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        if (error) {
            NSLog(@"remove picture for id:%@ failure",identifier);
            return false;
        }
        return true;
    }
    return false;
}

#pragma mark - 删除全部图片
- (BOOL)kl_removeCachePictures{
    if ([[NSFileManager defaultManager]fileExistsAtPath:cachesPath()]) {
        NSError * error;
        [[NSFileManager defaultManager] removeItemAtPath:cachesPath() error:&error];
        if (error) {
            NSLog(@"remove pictures fail , error : %@ , path = %@",error,cachesPath());
            return false;
        }
        return true;
    }
    return false;
}

#pragma mark - 缓存图片
- (BOOL)saveImageToCaches:(UIImage *)image identifier:(NSString *)identifier {
    NSData * imageData = UIImageJPEGRepresentation(image, 0.5);
    if (imageData) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:cachesPath()]) {
            NSError * error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:cachesPath()
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
            if (error) {
                NSLog(@"create cache dir error: %@   path: %@",error,cachesPath());
                return false;
            }
            NSLog(@"creat cache dir success :%@",cachesPath());
        }
        if (self.identifier) {
            NSString * path = [NSString stringWithFormat:@"%@/%@",cachesPath(),self.identifier];
            BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:path
                                                                     contents:imageData
                                                                   attributes:nil];
            if (isSuccess) {
                return YES;
            }
        }
    }
    return false;
}

- (UIImagePickerController *)imagePickerController{
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc]init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = kl_isEditImage;
    }
    return _imagePickerController;
}

static inline NSString * cachesPath(){
    return [NSString stringWithFormat:@"%@/klImageCaches",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0]];
}

- (void)dealloc{
    NSLog(@"dealloc : %@",self);
}

@end
