
#import "UITableViewCell+Extension.h"
#import <objc/runtime.h>

@implementation UITableViewCell (Extension)

static char rowKey;
- (void)setRow:(NSInteger)row {
    objc_setAssociatedObject(self, &rowKey, @(row), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)row {
    return [objc_getAssociatedObject(self, &rowKey) integerValue];
}

static char sectionKey;
- (void)setSection:(NSInteger)section {
    objc_setAssociatedObject(self, &sectionKey, @(section), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)section {
    return [objc_getAssociatedObject(self, &sectionKey) integerValue];
}

static char lineKey;
- (void)setLine:(UIView *)line {
    objc_setAssociatedObject(self, &lineKey, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)line {
    return objc_getAssociatedObject(self, &lineKey);
}

static char arrowKey;
- (void)setArrow:(UIImageView *)arrow {
    objc_setAssociatedObject(self, &arrowKey, arrow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)arrow {
    return objc_getAssociatedObject(self, &arrowKey);
}

- (void)remakeLineScreenWidth {
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)addLine {
    self.line = [[UIView alloc] init];
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    self.line.backgroundColor = AppLineColor;
}

- (void)addArrow {
    self.arrow = [[UIImageView alloc] init];
    [self addSubview:self.arrow];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(11);
        make.width.mas_equalTo(7);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-15);
    }];
    self.arrow.image = [UIImage imageNamed:@"cell_arrow"];
}

- (void)addTopSeparatorLine {
    self.line = [[UIView alloc] init];
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    self.line.backgroundColor = AppLineColor;
}

- (void)addBottomSeparatorLine {
    self.line = [[UIView alloc] init];
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    self.line.backgroundColor = AppLineColor;
}

- (void)removeLine {
    [self.line removeFromSuperview];
}

- (void)noneCellSelection {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end

/* 方案一  通过不让他重用cell 来解决重复显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 定义唯一标识
    static NSString *CellIdentifier = @"Cell";
    // 通过indexPath创建cell实例 每一个cell都是单独的
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // 对cell 进行简单地数据配置
    cell.textLabel.text = @"text";
    cell.detailTextLabel.text = @"text";
    cell.imageView.image = [UIImage imageNamed:@"4.png"];
    return cell;
}
*/

/* 方案二  同样通过不让他重用cell 来解决重复显示 不同的是每个cell对应一个标识
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 定义cell标识  每个cell对应一个自己的标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过不同标识创建cell实例
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // 对cell 进行简单地数据配置
    cell.textLabel.text = @"text";
    cell.detailTextLabel.text = @"text";
    cell.imageView.image = [UIImage imageNamed:@"4.png"];
    
    return cell;
}
*/


/* 方案三  当页面拉动需要显示新数据的时候，把最后一个cell进行删除 就有可以自定义cell 此方案即可避免重复显示，又重用了cell相对内存管理来说是最好的方案 前两者相对比较消耗内存
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 定义唯一标识
    static NSString *CellIdentifier = @"Cell";
    // 通过唯一标识创建cell实例
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    // 对cell 进行简单地数据配置
    cell.textLabel.text = @"text";
    cell.detailTextLabel.text = @"text";
    cell.imageView.image = [UIImage imageNamed:@"4.png"];
    
    return cell;
}
 */
