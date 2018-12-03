# KLBasicFramework
基础框架
本篇是 **iOS 搭建基础框架** 系列的最后一趴 **基础架构篇** 。

其他相关文章传送门如下： 

- [【iOS 搭建基础框架】编码规范 (命名规范篇)](https://juejin.im/post/5a67f1226fb9a01cbe657b43)
- [【iOS 搭建基础框架】编码规范 (代码格式篇)](https://juejin.im/post/5a67f54d5188253dc33224a8)
- [【iOS 搭建基础框架】目录结构篇](https://juejin.im/post/5a715e77518825733b0f30d2)

------

该系列的上一篇  [【iOS 搭建基础框架】目录结构篇](https://juejin.im/post/5a715e77518825733b0f30d2) 就已经定好了整个框架的结构层次, 本篇文章的内容就在于如何往  **BasicModule **模块里填充内容, 填充什么内容。

基础架构的目的在于构建一个通用的模板框架, 新的App只需要在模板框架上开发即可, 不用再为那些基础的功能而烦恼.

那么, 一个App不可或缺的都有哪些功能呢~

#### 1. Category

各式各样, 奇淫巧技的类别. 思考一下自己平常用到的类别方法, 整理归类出来. 也可以参考 大神[ibireme](https://github.com/ibireme)的 [YYCategories](https://github.com/ibireme/YYCategories) 框架,从里面挑选一些常用的方法, 集合到自己的框架里

#### 2. Utility

##### 2.1 HTTP

网络请求应该是必不可少的功能了, 也是重中之重~

谈到网络请求, [AFNetworking](https://github.com/AFNetworking/AFNetworking) 这位大哥威武. 但接下来要介绍的是这位小哥 [**YTKNetwork**](https://github.com/yuantiku/YTKNetwork) 猿题库开源的基于  [AFNetworking](https://github.com/AFNetworking/AFNetworking) 封装的网络框架, 看过来 [YTKNetwork使用](https://github.com/yuantiku/YTKNetwork/blob/master/Docs/README_cn.md)

这个框架的Star已经说明了它的实用性, 以下摘抄自  [YTKNetwork使用](https://github.com/yuantiku/YTKNetwork/blob/master/Docs/README_cn.md)

- 将网络请求与具体的第三方库依赖隔离，方便以后更换底层的网络库。实际上 YTKNetwork 最初是基于 ASIHttpRequest 的，我们只花了两天，就很轻松地切换到了 AFNetworking。
- 方便在基类中处理公共逻辑，例如猿题库的数据版本号信息就统一在基类中处理。
- 方便在基类中处理缓存逻辑，以及其它一些公共逻辑。
- 方便做对象的持久化。

是真的好用, 而且对于中小型的App, 完全够用. 我是用的挺爽的~

##### 2.2 HUD (透明指示层) 

网络请求的过程中, 为了防止可爱的用户们情绪失控, 砸手机, HUD就该登场了. 话不多说, 请上大佬 [MBProgressHUD](https://github.com/jdg/MBProgressHUD), 在此基础上封装一层, 搞定~

##### 2.3 AlertView

警告, 选择等弹出框 推荐 [SCLAlertView](https://github.com/dogo/SCLAlertView) , 简约, 大方, 有气质, I like it~

##### 2.4 RefreshView

刷新控件..... (⊙x⊙;)闭嘴 [MJRefresh](https://github.com/CoderMJLee/MJRefresh)

##### 2.5 Log

日志输入, 这边走 [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack)

#### 3. 基类

由于都是一个人开发, 基类设计采用的是 **继承** 的方式来开发的, 详细的看这里  [KLBasicFramework](https://github.com/CoderKLLee/KLBasicFramework) 的 `Class -> SuperClass`

上面说到的一切, 在这里都能找到 ,  [KLBasicFramework](https://github.com/CoderKLLee/KLBasicFramework) 就酱~


