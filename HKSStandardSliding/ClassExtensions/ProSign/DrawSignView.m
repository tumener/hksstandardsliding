//
//  DrawSignView.m
//  YRF
//
//  Created by jun.wang on 14-5-28.
//  Copyright (c) 2014年 王军. All rights reserved.
//


#import "DrawSignView.h"
#import "KSLocalizedKeys.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define SYSTEMFONT(x) [UIFont systemFontOfSize:(x)]

@interface DrawSignView ()
@property (strong,nonatomic)  MyView *drawView;
@property (assign,nonatomic)  BOOL buttonHidden;
@property (assign,nonatomic)  BOOL widthHidden;
@end

//保存线条颜色
static NSMutableArray *colors;

@implementation DrawSignView{
    UIButton *redoBtn;//撤销
    UIButton *undoBtn;//恢复
    UIButton *clearBtn;//清空
    UIButton *colorBtn;//颜色
    UIButton *screenBtn;//截屏
    UIButton *widthBtn;//高度
    UIButton *okBtn;//确定并截图返回
    UIButton *cancelBtn;//取消
    UISlider *penBoldSlider;
}

@synthesize signCallBackBlock,cancelBlock;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createView];
    }
    return self;
}

- (void)createView
{
    CGFloat buttonWidth = 40;
    CGFloat offsetX = buttonWidth+40;
    
    CGRect buttonOKFrame = CGRectMake(offsetX, 500-1.2*buttonWidth-10, buttonWidth, buttonWidth);
    CGRect buttonCancelFrame = CGRectOffset(buttonOKFrame, offsetX, 0.0);
    CGRect buttonRedoFrame = CGRectOffset(buttonOKFrame, 2.5*offsetX, 0);
    CGRect buttonUndoFrame = CGRectOffset(buttonOKFrame, 3.5*offsetX, 0);
    CGRect buttonClearFrame = CGRectOffset(buttonOKFrame,4.5*offsetX, 0);

    //self
    self.frame = CGRectMake(0, 0, 1000, 500);
    self.backgroundColor = [UIColor colorWithRed:59./255. green:73./255. blue:82./255. alpha:1];
    CALayer *layer = self.layer;
    [layer setCornerRadius:15.0];
    layer.borderColor = [[UIColor grayColor] CGColor];
    layer.borderWidth = 1;

    //contentLbl
    UILabel *contentLbl = [[UILabel alloc]init];
    contentLbl.text = NSLocalizedString(LSProsignTitle,nil);
    contentLbl.textAlignment = NSTextAlignmentCenter;
    contentLbl.textColor = [UIColor whiteColor];
    contentLbl.frame = CGRectMake(0, 10, 1000, 30);
    contentLbl.font = [UIFont boldSystemFontOfSize:20.0];
    contentLbl.backgroundColor = [UIColor clearColor];
    [self addSubview:contentLbl];

    //btns
    //undoBtn
    undoBtn = [[UIButton alloc]initWithFrame:buttonUndoFrame];
    [undoBtn setBackgroundImage:[UIImage imageNamed:@"redoBlack.png"] forState:UIControlStateNormal];
    [self addSubview:undoBtn];
    [undoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    redoBtn = [[UIButton alloc]initWithFrame:buttonRedoFrame];
    [redoBtn setBackgroundImage:[UIImage imageNamed:@"undoBlack.png"] forState:UIControlStateNormal];
    [self addSubview:redoBtn];
    [redoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //clearBtn
    clearBtn = [[UIButton alloc]initWithFrame:buttonClearFrame];
    [clearBtn setBackgroundImage:[UIImage imageNamed:@"trash.png"] forState:UIControlStateNormal];
    [self addSubview:clearBtn];
     [clearBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //okBtn
    okBtn = [[UIButton alloc]initWithFrame:buttonOKFrame];
    [okBtn setBackgroundImage:[UIImage imageNamed:@"okBlack.png"] forState:UIControlStateNormal];
    [self addSubview:okBtn];
    [okBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //cancelBtn
    cancelBtn = [[UIButton alloc]initWithFrame:buttonCancelFrame];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancelBlack.png"] forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

    //penBoldSlider
    penBoldSlider = [[UISlider alloc]init];
    penBoldSlider.frame = CGRectMake(200+10, 400, 200, 20);
    penBoldSlider.minimumValue = 0;
    penBoldSlider.maximumValue = 9;
    penBoldSlider.value = 0;
    [penBoldSlider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
//    [self addSubview:penBoldSlider];

    //
    colors = [[NSMutableArray alloc]initWithObjects:[UIColor greenColor],[UIColor blueColor],[UIColor redColor],[UIColor blackColor],[UIColor whiteColor], nil];
    self.buttonHidden=YES;
    self.widthHidden=YES;
    self.drawView = [[MyView alloc]initWithFrame:CGRectMake(10, 50, 980, 440)];
    self.drawView.layer.cornerRadius = 15.0;
//    [self.drawView setBackgroundColor:RGBCOLOR(0, 140.0, 87.0)];//RGBCOLOR(101, 129, 90)];
    [self.drawView setBackgroundColor:RGBCOLOR(0, 140, 87)];    // (101, 129,90)
    [self addSubview: self.drawView];
    [self sendSubviewToBack:self.drawView];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)changeColors:(id)sender{
    if (self.buttonHidden==YES) {
        for (int i=1; i<6; i++) {
            UIButton *button=(UIButton *)[self viewWithTag:i];
            button.hidden=NO;
            self.buttonHidden=NO;
        }
    }else{
        for (int i=1; i<6; i++) {
            UIButton *button=(UIButton *)[self viewWithTag:i];
            button.hidden=YES;
            self.buttonHidden=YES;
        }
    }
}

-(void)changeWidth:(id)sender{
    if (self.widthHidden==YES) {
        for (int i=11; i<15; i++) {
            UIButton *button=(UIButton *)[self viewWithTag:i];
            button.hidden=NO;
            self.widthHidden=NO;
        }
    }else{
        for (int i=11; i<15; i++) {
            UIButton *button=(UIButton *)[self viewWithTag:i];
            button.hidden=YES;
            self.widthHidden=YES;
        }

    }

}
- (void)widthSet:(id)sender {
    UIButton *button=(UIButton *)sender;
    [self.drawView setlineWidth:button.tag-10];
}

- (UIImage *)saveScreen{

    UIView *screenView = self.drawView;

    for (int i=1; i<16;i++) {
        UIView *view=[self viewWithTag:i];
        if ((i>=1&&i<=5)||(i>=10&&i<=15)) {
            if (view.hidden==YES) {
                continue;
            }
        }
        view.hidden=YES;
        if(i>=1&&i<=5){
            self.buttonHidden=YES;
        }
        if(i>=10&&i<=15){
            self.widthHidden=YES;
        }
    }
    UIGraphicsBeginImageContext(screenView.bounds.size);
    [screenView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(image, screenView, nil, nil);
//    for (int i=1;i<16;i++) {
//        if ((i>=1&&i<=5)||(i>=11&&i<=14)) {
//            continue;
//        }
//        UIView *view=[self viewWithTag:i];
//        view.hidden=NO;
//    }
    image = [DrawSignView imageToTransparent:image];
    return image;//[image retain];
}

- (void)colorSet:(id)sender {
    UIButton *button=(UIButton *)sender;
    [self.drawView setLineColor:button.tag-1];
    colorBtn.backgroundColor=[colors objectAtIndex:button.tag-1];
}

/** 封装的按钮事件 */
-(void)btnAction:(id)sender{
    if (sender == cancelBtn) {
        cancelBlock();
    }else if (sender == okBtn){
        signCallBackBlock([self saveScreen]);
    }else if (sender == redoBtn){
       [ self.drawView revocation];
    }else if(sender == undoBtn){
        [ self.drawView refrom];
    }else if(sender == clearBtn){
        [self.drawView clear];
    }
}


/** 笔触粗细 */
-(void)updateValue:(id)sender{
    if (sender == penBoldSlider) {
        CGFloat f = penBoldSlider.value;
        NSLog(@"%f",f);
        NSInteger w = (int)ceilf(f);
        [self.drawView setlineWidth:w];
    }
}

/** 颜色变化 */
void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}

//颜色替换
+ (UIImage*) imageToTransparent:(UIImage*) image
{
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);

    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);

    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        //把绿色变成黑色，把背景色变成透明
        //if ((*pCurPtr & 0x65815A00) == 0x65815a00)    // 将背景变成透明
        if((*pCurPtr & 0x008C5700) == 0x008c5700)
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
        else if ((*pCurPtr & 0x00FF0000) == 0x00ff0000)    // 将绿色变成黑色
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = 0; //0~255
            ptr[2] = 0;
            ptr[1] = 0;
        }
        else if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00)    // 将白色变成透明
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
        else
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = 0; //0~255
            ptr[2] = 0;
            ptr[1] = 0;
        }

    }

    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);

    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];

    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free
    
    return resultUIImage;
}

- (UIImage *) imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
