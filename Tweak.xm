@interface IGDate : NSObject
-(NSDate *)date;
-(NSInteger)microseconds;
-(CGFloat)timeIntervalSince1970;
@end

@interface IGFeedItem : NSObject
-(IGDate *)takenAtDate;
@end

%hook IGFeedNetworkSource

/*-(NSArray *)downloadedPosts {
	return nil;
}*/

-(NSArray *)posts {
	NSArray *posts = %orig;
	NSArray *timeSortedPosts = [posts sortedArrayUsingComparator:^NSComparisonResult(IGFeedItem *item1, IGFeedItem *item2) {
			if (item1.takenAtDate.date < item2.takenAtDate.date)
				return NSOrderedDescending;
			else if (item1.takenAtDate.date > item2.takenAtDate.date)
				return NSOrderedAscending;
			return NSOrderedSame;
		}];
	return timeSortedPosts;
}

%end