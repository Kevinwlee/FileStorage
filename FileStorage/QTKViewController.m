//
//  QTKViewController.m
//  FileStorage
//
//  Created by Kevin Lee on 7/28/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKViewController.h"
#import "QTKPathHelpers.h"

@interface QTKViewController ()

@end

@implementation QTKViewController
@synthesize tableView = _tableView;
@synthesize items;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)createData:(id)sender {
    dispatch_async(dispatch_queue_create("qteko.file.queue", nil), ^{
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < 10000; i++) {
            NSString *title = [NSString stringWithFormat:@"some item %d",i];
            NSNumber *identity = [NSNumber numberWithInt:i];
            [temp addObject:[NSDictionary dictionaryWithObjectsAndKeys:title,@"title", identity, @"id",nil ]];
        }
        NSString *path = PathForFileInDocumentsDirectory(@"data");
        BOOL OK = [temp writeToFile:path atomically:YES];
        if (!OK) {
            NSLog(@"that didn't work");
        }
        
    });
    
}

- (IBAction)destroyData:(id)sender {
    self.items = nil;
    self.items = [NSArray array];
    
}

- (IBAction)loadData:(id)sender {
    dispatch_async(dispatch_queue_create("qteko", nil), ^{
        NSString *path = PathForFileInDocumentsDirectory(@"data");
        self.items = [NSArray arrayWithContentsOfFile:path];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (IBAction)loadFilteredData:(id)sender {
    dispatch_async(dispatch_queue_create("qteko", nil), ^{
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"id < 500"];
        NSString *path = PathForFileInDocumentsDirectory(@"data");
        NSArray *allItems = [NSArray arrayWithContentsOfFile:path];
        self.items = [allItems filteredArrayUsingPredicate:pred];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellidentifier = @"cellidentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    
    cell.textLabel.text = [[self.items objectAtIndex:indexPath.row] valueForKey:@"title"];

    return cell;
}


@end
