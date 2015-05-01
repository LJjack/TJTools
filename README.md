# CYTools
在开发过程中自己写过的工具和收集的工具

---

#### ActionSheet	`类似系统的ActionSheet，来自于网络`

```objc
__weak typeof(self)weakSelf = self;
IBActionSheet *actionSheet = [[IBActionSheet alloc] initWithTitle:@"选择付款方式"
                                                         callback:^(IBActionSheet *actionSheet, NSInteger buttonIndex){
                                                         //to do something                                                         
        }
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"支付宝",@"微支付",nil];
        [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}];
```

---

#### Encrypt  `加密类`

```objc
//Sha1加密
[CYEncrypt sha1:@"我是加密字符串"];
//md5加密
[CYEncrypt md5:@"我是加密字符串"];
```

---

#### CYLabel		`label添加删除线、下划线`

```objc
CYLabel *price [CYLabel new];
price.lineType = CYLabelLineTypeMiddle;
price.strikeColor = [UIColor redColor];
price.strikeThroughEnabled = YES
```

---

#### CYDropMenu		`顶部排序按钮`

```objc
__weak typeof(self)weakSelf = self;
NSArray *titles = @[@"全部",@"价格",@"销量",@"评价"];
CYDropMenu *menu = [[CYDropMenu alloc] initWithArray:titles selectedColor:[UIColor redColor] frame:CGRectMake(0, 0, kScreenWidth, 40)];
  [menu CYDropMenuDidTappedUsingBlock:^(NSInteger menuIndex) {
      __strong typeof(weakSelf)strongSelf = weakSelf;
      strongSelf.lblTest.text = [NSString stringWithFormat:@"点击了 %@",titles[menuIndex]];
      NSLog(@"点击了 %@",titles[menuIndex]);
}];
```

---

#### LXShare		`自定义分享，来自于网络，针对项目稍改了些样式`

```objc
__weak typeof(self)weakSelf = self;
NSArray *titles = @[@"全部",@"价格",@"销量",@"评价"];
CYDropMenu *menu = [[CYDropMenu alloc] initWithArray:titles selectedColor:[UIColor redColor] frame:CGRectMake(0, 0, kScreenWidth, 40)];
  [menu CYDropMenuDidTappedUsingBlock:^(NSInteger menuIndex) {
      __strong typeof(weakSelf)strongSelf = weakSelf;
      strongSelf.lblTest.text = [NSString stringWithFormat:@"点击了 %@",titles[menuIndex]];
      NSLog(@"点击了 %@",titles[menuIndex]);
}];
```

#### SecurityStrategy		`后台模糊效果，类似支付裱，来自于网络`

在Appdelegate中添加以下方法
```objc
- (void)applicationWillResignActive:(UIApplication *)application {
    //添加模糊效果
    [SecurityStrategy addBlurEffect];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    //移除模糊效果
    [SecurityStrategy removeBlurEffect];
}
```


---

# Categorys	`实用的功能`


---

#### UIColor+Hex			`16进制颜色转换工具,来自于网络`

```objc
[UIColor colorWithHex:0xffffff];
[UIColor colorWithHex:0xffffff alpha:0.8];
[UIColor colorWithHexString:@"ffffff"];
```

---

#### UIView+Extension		`便捷获取view的bounds，感谢兴旺的提供`

```objc
CGFloat viewX = self.view.x;			instead  self.view.frame.origin.x
CGFloat viewY = self.view.y;			instead  self.view.frame.origin.y
CGFloat viewW = self.view.width;		instead	 self.view.frame.size.width
CGFloat viewH = self.view.height;		instead	 self.view.frame.size.height
```

---

#### UIButton+CYExtension		`一句话button添加block回调`

```objc
UIButton *button = [UIButton new];
[button addTargetWithBlock:^(UIButton *sender) {
     NSLog(@"点我点我");
} forControlEvents:UIControlEventTouchUpInside];
```

---

#### UIAlertView+CYAlert		`一句话调出AlertView，block回调`

```objc
[UIAlertView alertViewWithBlock:^(NSInteger buttonIndex) {
            //do something
        } title:@"温馨提示" message:@"我是消息" cancelButtonName:@"好" otherButtonTitles:nil];
```



