//
//  QTKViewController.h
//  FileStorage
//
//  Created by Kevin Lee on 7/28/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTKTodo.h"

@interface QTKViewController : UIViewController <UITableViewDataSource>
@property (nonatomic, strong)NSArray *items;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)createData:(id)sender;
- (IBAction)destroyData:(id)sender;
- (IBAction)loadData:(id)sender;
- (IBAction)loadFilteredData:(id)sender;



@end
