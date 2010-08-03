//
//  StatesViewController.m
//  IndexedTable
//
//  Created by cwiles on 2/24/10.
//  Copyright 2010 Wiles, LLC. All rights reserved.
//  web: http://www.corywiles.com/
//  email: kwylez@gmail.com
//

#import "StatesViewController.h"


@implementation StatesViewController

@synthesize states;
@synthesize arrayOfCharacters;
@synthesize objectsForCharacters;

- (void)viewDidLoad {
  
  self.states = [NSArray arrayWithObjects:@"Alabama",  
                 @"Alaska",  
                 @"Arizona",  
                 @"Arkansas",  
                 @"California",  
                 @"Colorado",  
                 @"Connecticut",  
                 @"Delaware",  
                 @"District Of Columbia",  
                 @"Florida", 
                 @"Georgia",  
                 @"Hawaii",  
                 @"Idaho",  
                 @"Illinois",  
                 @"Indiana",  
                 @"Iowa",  
                 @"Kansas",  
                 @"Kentucky",  
                 @"Louisiana",  
                 @"Maine",  
                 @"Maryland",  
                 @"Massachusetts",  
                 @"Michigan",  
                 @"Minnesota",  
                 @"Mississippi",  
                 @"Missouri",  
                 @"Montana",
                 @"Nebraska",
                 @"Nevada",
                 @"New Hampshire",
                 @"New Jersey",
                 @"New Mexico",
                 @"New York",
                 @"North Carolina",
                 @"North Dakota",
                 @"Ohio",  
                 @"Oklahoma",  
                 @"Oregon",  
                 @"Pennsylvania",  
                 @"Rhode Island",  
                 @"South Carolina",  
                 @"South Dakota",
                 @"Tennessee",  
                 @"Texas",  
                 @"Utah",  
                 @"Vermont",  
                 @"Virginia",  
                 @"Washington",  
                 @"West Virginia",  
                 @"Wisconsin",  
                 @"Wyoming", nil
                 ];
  
  [self setupIndexData];
  
  [super viewDidLoad];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [arrayOfCharacters count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  /**
   * Return number of states per letter
   */
  return [[objectsForCharacters objectForKey:[arrayOfCharacters objectAtIndex:section]] count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
  if ([arrayOfCharacters count] == 0) {
    return @"";
  }
  
  return [NSString stringWithFormat:@"%@", [arrayOfCharacters objectAtIndex:section]];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
  
  NSArray *toBeReturned = [NSArray arrayWithArray:
                           [@"A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|#"
                         componentsSeparatedByString:@"|"]];
  
  return toBeReturned;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
  
  NSInteger count = 0;
  
  for (NSString *character in arrayOfCharacters) {
    
    if ([character isEqualToString:title]) {
      return count;  
    }
    
    count ++;
  }
  
  return 0;// in case of some eror donot crash d application
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
    
  // Set up the cell...
  cell.textLabel.text = [[objectsForCharacters objectForKey:[arrayOfCharacters objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	
  return cell;
}

- (void)setupIndexData {
  
  self.arrayOfCharacters    = [[NSMutableArray alloc] init];
  self.objectsForCharacters = [[NSMutableDictionary alloc] init];
  
  NSMutableArray *arrayOfNames = [[NSMutableArray alloc] init];
  NSString *firstLetter;
  
  for (NSString *state in self.states) {
    
    NSLog(@"state: %@", state);
    
    firstLetter = [state substringToIndex:1];
    
    /**
     * If the letter doesn't exist in the dictionary go ahead and add it the 
     * dictionary.
     *
     * ::IMPORTANT::
     * You HAVE to removeAllObjects from the arrayOfNames or you will have an N + 1
     * problem.  Let's say that start with the A's, well once you hit the 
     * B's then in your table you will the A's and B's for the B's section.  Once 
     * you hit the C's you will all the A's, B's, and C's, etc.
     */
    if (![objectsForCharacters objectForKey:firstLetter]) {

      [arrayOfNames removeAllObjects];
      
      [arrayOfCharacters addObject:[NSString stringWithFormat:@"%@",firstLetter]];
    } 
      
    [arrayOfNames addObject:state];
    
    /**
     * NOTE:: CDW
     * Need to autorelease the copy to preven potential leak.  Even though the 
     * arrayOfNames is released below it still has a retain count of +1
     */
    [objectsForCharacters setObject:[[arrayOfNames copy] autorelease] forKey:[NSString stringWithFormat:@"%@",firstLetter]];
    
  }

  [arrayOfNames release];  
 
  [self.tableView reloadData];
}


- (void)dealloc {
  [states release];
  [arrayOfCharacters release];
  [objectsForCharacters release];
  [super dealloc];
}


@end

