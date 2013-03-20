//
//  ViewController.m
//  CoolTable
//
//  Created by offspring on 13-1-11.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import "ViewController.h"
#import "AddViewController.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

@interface ViewController (){
    NSString *_path;
}

@property (nonatomic,strong) NSMutableArray *breakfast,*lunch,*dinner;
@property (nonatomic,strong) NSArray *meals;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"摇饭";
    //获取存储路径
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *ds = directories[0];
    _path = [ds stringByAppendingPathComponent:@"meals.archive"];
    
    self.meals = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    if (self.meals.count == 0) {
    self.breakfast = [NSMutableArray arrayWithObjects:@"馄饨",@"包子",@"粥", nil];
    self.lunch = [NSMutableArray arrayWithObjects:@"咖喱饭",@"照烧鸡", nil];
    self.dinner = [NSMutableArray arrayWithObjects:@"腊肠",@"锅包肉", @"海鲜", nil];
        self.meals = [NSArray arrayWithObjects:self.breakfast,self.lunch,self.dinner,nil];
    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%d",indexPath.section]];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%d",indexPath.section]];
//    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //set cell's textfield's value
//    NSString *entry;
//    if (indexPath.section == 0) {
//        entry = [_breakfast objectAtIndex:indexPath.row];
//    }
//    else if (indexPath.section == 1){
//        entry = [_lunch objectAtIndex:indexPath.row];
//    }
//    else{
//        entry = [_dinner objectAtIndex:indexPath.row];
//    }
//    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, cell.bounds.size.width, cell.bounds.size.height - 10)];
//    [myTextField setBackgroundColor:[UIColor clearColor]];
//    myTextField.delegate = self;
//    myTextField.text = [((NSMutableArray *)[self.meals objectAtIndex:indexPath.section])[indexPath.row] copy];
//    [myTextField setTextAlignment:NSTextAlignmentCenter];
//    [myTextField setTag:(indexPath.section * 10 + indexPath.row)];
//    [cell addSubview:myTextField];
    cell.textLabel.text = [((NSMutableArray *)[self.meals objectAtIndex:indexPath.section])[indexPath.row] copy];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    cell.backgroundView = [[CustomCellBackground alloc] initWithFrame:cell.backgroundView.bounds];
    cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSMutableArray *)self.meals[section]).count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"早饭";
    }
    else if(section == 1){
        return @"午餐";
    }
    else{
        return @"晚饭";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //因为nsstring是指针，所以不能直接用==，要对对象调用方法
    NSLog(@"yes");
    if ([segue.identifier isEqualToString:@"addSegue"]) {
        AddViewController *addViewController = [segue destinationViewController];
        [addViewController setDelegate:self];
    }
}

//addDelegate方法
- (void)addNewDisk:(NSString *)diskName forMeal:(NSInteger)meal{
    [((NSMutableArray *)(self.meals[meal])) addObject:diskName];
    [NSKeyedArchiver archiveRootObject:self.meals toFile:_path];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CustomHeader *header = [[CustomHeader alloc] init];
    header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    [header.titleLabel bringSubviewToFront:header];
    if (section == 1) {
        header.lightColor = [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:216.0/255.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:72.0/255.0 green:22.0/255.0 blue:137.0/255.0 alpha:1.0];
    }
    else if (section == 2){
        header.lightColor = [UIColor colorWithRed:255.0/255.0 green:0.0/0.0 blue:0.0/0.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:180.0/255.0 green:0.0/0.0 blue:0.0/0.0 alpha:1.0];
    }
    return header;
}
@end
