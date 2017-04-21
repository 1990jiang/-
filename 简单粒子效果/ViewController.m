//
//  ViewController.m
//  简单粒子效果
//
//  Created by 蒋俊 on 17/4/21.
//  Copyright © 2017年 蒋俊. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIButton *emitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [emitterBtn setTitle:@"粒子出来" forState:UIControlStateNormal];
    
    [emitterBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [emitterBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    emitterBtn.frame = CGRectMake(0, 0, 100, 40);
    emitterBtn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 20);
   
    [emitterBtn addTarget:self action:@selector(emitterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    emitterBtn.selected = NO;
    [self.view addSubview:emitterBtn];
    
}

#pragma mark -- 粒子发射按钮
-(void)emitterBtnClick:(UIButton *)btn{
    
    if (btn.selected == NO) {
        [self setupEmitter];
        btn.selected = YES;
    }else{
        [self stopEmitter];
        btn.selected = NO;
        
    }
    
}

//完整粒子效果
-(void)setMultipleEmitterCell{
    
    // 1.创建发射器
    CAEmitterLayer *emitter = [[CAEmitterLayer alloc]init];
    
    // 2.设置发射器的位置
    emitter.emitterPosition = CGPointMake(self.view.center.x, self.view.bounds.size.height - 20);
    
    // 3.开启三维效果
    emitter.preservesDepth = YES;
   //创建多个粒子
    NSMutableArray *cellArr = [NSMutableArray array];
    for (int i = 0 ; i < 9; i++) {
    
        CAEmitterCell *cell = [[CAEmitterCell alloc]init];
        
        cell.velocity = 150;
        cell.velocityRange = 100;
        
        cell.scale = 0.7;
        cell.scaleRange = 0.3;
        
        cell.emissionLongitude = -M_PI_2;
        cell.emissionRange = M_PI_2 / 8;
        
        cell.lifetime = 6;
        cell.lifetimeRange = 1.5;
      
        cell.spin = M_PI_2;
        cell.spinRange = M_PI_2 / 2;
      
        cell.birthRate = 2;
     
        cell.contents = (__bridge id _Nullable)([UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30",i+1]].CGImage);
      
        //将创建出来的cell加入到数组中
        [cellArr addObject:cell];
        
        
    }
    // 5.将粒子设置到发射器中
    emitter.emitterCells = cellArr;
    
   // 6.将发射器的layer添加到父layer中
    [self.view.layer addSublayer:emitter];
}

//最简单的粒子效果
-(void)setupEmitter{
    
    // 1.创建发射器
    CAEmitterLayer *emitter = [[CAEmitterLayer alloc]init];
    
    // 2.设置发射器的位置
    emitter.emitterPosition = CGPointMake(self.view.center.x, self.view.bounds.size.height - 20);
    
    // 3.开启三维效果--可以关闭三维效果看看
    emitter.preservesDepth = YES;
    
    // 4.创建粒子, 并且设置粒子相关的属性
    // 4.1.创建粒子Cell
    CAEmitterCell *cell = [[CAEmitterCell alloc]init];
    
    // 4.2.设置粒子速度
    cell.velocity = 150;
    //速度范围波动50到250
    cell.velocityRange = 100;
    
    // 4.3.设置粒子的大小
    //一般我们的粒子大小就是图片大小， 我们一般做个缩放
    cell.scale = 0.7;
   
   //粒子大小范围: 0.4 - 1 倍大
    cell.scaleRange = 0.3;
    
    // 4.4.设置粒子方向
    //这个是设置经度，就是竖直方向 --具体看我们下面图片讲解
    //这个角度是逆时针的，所以我们的方向要么是 (2/3 π)， 要么是 (-π)
    cell.emissionLongitude = -M_PI_2;
    
    cell.emissionRange = M_PI_2 / 4;
    
    // 4.5.设置粒子的存活时间
    cell.lifetime = 6;
    cell.lifetimeRange = 1.5;
    // 4.6.设置粒子旋转
    cell.spin = M_PI_2;
    cell.spinRange = M_PI_2 / 2;
    // 4.6.设置粒子每秒弹出的个数
    cell.birthRate = 20;
    // 4.7.设置粒子展示的图片 --这个必须要设置为CGImage
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"good5_30x30"].CGImage);
    // 5.将粒子设置到发射器中--这个是要放个数组进去
    emitter.emitterCells = @[cell];
    // 6.将发射器的layer添加到父layer中
    [self.view.layer addSublayer:emitter];
   
  
}

//移除粒子发射器
-(void)stopEmitter{
    
    for (CALayer *emitter in self.view.layer.sublayers) {
        if ([emitter isKindOfClass:[CAEmitterLayer class]]) {
            [emitter removeFromSuperlayer];
        }
    }
    
    
    
}


@end
