//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Paul Kitchener on 10/5/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *toDoTextField;
@property (weak, nonatomic) IBOutlet UITableView *toDoTableView;
@property NSMutableArray *tasks;
@property NSIndexPath *indexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Task *task1 = [[Task alloc] initWithTask:@"Homework" andColor:[UIColor blackColor] andPriority:1];
    Task *task2 = [[Task alloc] initWithTask:@"Take out the trash" andColor:[UIColor blackColor] andPriority:1];
    Task *task3 = [[Task alloc] initWithTask:@"Walk the dog" andColor:[UIColor blackColor] andPriority:1];
    Task *task4 = [[Task alloc] initWithTask:@"Finish app" andColor:[UIColor blackColor] andPriority:1];

    self.tasks = [NSMutableArray arrayWithObjects: task1, task2, task3, task4, nil];

    [self.toDoTableView setEditing:NO animated:YES];
}

#pragma mark IBActions

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    Task *task = [Task new];
    task.task = self.toDoTextField.text;
    [self.tasks addObject:task];
    [self.toDoTableView reloadData];
    self.toDoTextField.text = @"";
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {

    if (self.editing) {
        self.editing = false;
        [self.toDoTableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else {
        self.editing = true;
        [self.toDoTableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
    }
}

- (IBAction)onSwipeRight:(UISwipeGestureRecognizer *)location {

    CGPoint point = [location locationInView:self.toDoTableView];
    NSIndexPath *indexPath = [self.toDoTableView indexPathForRowAtPoint:point];
    UITableViewCell *cell = [self.toDoTableView cellForRowAtIndexPath:indexPath];

    Task *task = [Task new];
    task = [self.tasks objectAtIndex:indexPath.row];
    task.priority++;

    for (task in self.tasks) {
        if (task.priority == 1) {
            task.color = [UIColor blackColor];
        } else if (task.priority == 2) {
            task.color = [UIColor greenColor];
        } else if (task.priority == 3) {
            task.color = [UIColor yellowColor];
        } else if (task.priority == 4) {
            task.color = [UIColor redColor];
        } else if (task.priority == 5) {
            task.priority = 1;
            task.color = [UIColor blackColor];
        }
    }

    cell.textLabel.text = task.task;
    cell.textLabel.textColor = task.color;

    [self.toDoTableView reloadData];

}

#pragma mark - Methods


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to delete this?" message:nil preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *deleteButton = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.toDoTableView reloadData];
    }];

    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [self.toDoTableView reloadData];
    }];

    [alertController addAction:deleteButton];
    [alertController addAction:cancelButton];

    [self presentViewController:alertController animated:YES completion:nil];

    [self.toDoTableView reloadData];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Task *task = [self.tasks objectAtIndex:indexPath.row];

    cell.textLabel.text = task.task;
    cell.textLabel.textColor = task.color;
    return cell;
}


@end
