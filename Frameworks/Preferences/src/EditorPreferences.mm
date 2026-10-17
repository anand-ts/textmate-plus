#import "EditorPreferences.h"
#import "Keys.h"
#import <OakAppKit/OakUIConstructionFunctions.h>

@implementation EditorPreferences
- (id)init
{
	if(self = [super initWithNibName:nil label:@"Editor" image:[NSImage imageNamed:NSImageNameFontPanel]])
	{
		self.defaultsProperties = @{
			@"disableCaretBlink": kUserDefaultsDisableCaretBlinkKey,
		};
	}
	return self;
}

- (void)loadView
{
	NSButton* blinkCursorCheckBox = OakCreateCheckBox(@"Blink cursor");
	NSButton* lineNumbersCheckBox = OakCreateCheckBox(@"Show line numbers");
	NSGridView* gridView = [NSGridView gridViewWithViews:@[
		@[ OakCreateLabel(@"Cursor:"), blinkCursorCheckBox ],
		@[ OakCreateLabel(@"Gutter:"), lineNumbersCheckBox ],
	]];

	self.view = OakSetupGridViewWithSeparators(gridView);

	[blinkCursorCheckBox bind:NSValueBinding toObject:self withKeyPath:@"disableCaretBlink" options:@{ NSValueTransformerNameBindingOption: NSNegateBooleanTransformerName }];
	[lineNumbersCheckBox bind:NSValueBinding toObject:NSUserDefaultsController.sharedUserDefaultsController withKeyPath:[NSString stringWithFormat:@"values.%@", kUserDefaultsDisableLineNumbersKey] options:@{ NSValueTransformerNameBindingOption: NSNegateBooleanTransformerName }];
}
@end
