#import "Kiwi.h"
#import "TaskItem.h"

SPEC_BEGIN(TaskItemSpec)

	describe(@"TaskItem", ^{
		__block TaskItem *stu;

		it(@"should initialize with name", ^{
			stu = [[TaskItem alloc] initWithName:@"Testing"];
			[[[stu taskName] should] equal:@"Testing"];
		});
	});

SPEC_END