# SKDynamicChangeCellHeightDemo
动态改变cell的高度 点击关闭 和 点击打开
## 动态改变cell的高度
创建一个数组，记用点哪一行，记录索引，封装成NSNumber，放进数组,刷新tableview。
在创建cell高度的时候，进行判断当前的行数是否在数组里面，是的话。创建不同的高度。

