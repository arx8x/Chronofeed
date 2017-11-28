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

-(NSArray *)posts
{
	NSArray *posts = %orig;

	NSArray *timeSortedPosts = [posts sortedArrayUsingComparator:
	^NSComparisonResult(IGFeedItem *item1, IGFeedItem *item2)
	{
		if(![item1 respondsToSelector:@selector(takenAtDate)] || ![item2 respondsToSelector:@selector(takenAtDate)])
		{
			return 1;
		}
		return [item2.takenAtDate.date compare:item1.takenAtDate.date];
	}
	];
	[timeSortedPosts description];
	return timeSortedPosts;
}

%end
