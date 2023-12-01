const AppKit_NSApplication = @import("./AppKit/NSApplication/frontend.zig");
pub const NSApplication = AppKit_NSApplication.NSApplication;
pub const NSApplicationDelegate = AppKit_NSApplication.NSApplicationDelegate;
pub const NSModalResponse = AppKit_NSApplication.NSModalResponse;

const AppKit_NSRunningApplication = @import("./AppKit/NSRunningApplication/frontend.zig");
pub const NSApplicationActivationPolicy = AppKit_NSRunningApplication.NSApplicationActivationPolicy;

const AppKit_NSWindow = @import("./AppKit/NSWindow/frontend.zig");
pub const NSWindowStyleMask = AppKit_NSWindow.NSWindowStyleMask;
pub const NSWindow = AppKit_NSWindow.NSWindow;
pub const NSWindowDelegate = AppKit_NSWindow.NSWindowDelegate;

const AppKit_NSGraphics = @import("./AppKit/NSGraphics/frontend.zig");
pub const NSBackingStoreType = AppKit_NSGraphics.NSBackingStoreType;

const AppKit_NSScreen = @import("./AppKit/NSScreen/frontend.zig");
pub const NSScreen = AppKit_NSScreen.NSScreen;

const AppKit_NSColor = @import("./AppKit/NSColor/frontend.zig");
pub const NSColor = AppKit_NSColor.NSColor;
pub const NSColorSystemEffect = AppKit_NSColor.NSColorSystemEffect;

const AppKit_NSResponder = @import("./AppKit/NSResponder/frontend.zig");
pub const NSResponder = AppKit_NSResponder.NSResponder;
const AppKit_NSResponder_Backend = @import("./AppKit/NSResponder/backend.zig");
pub const NSStandardKeyBindingRespondingSelectors = AppKit_NSResponder_Backend.NSStandardKeyBindingRespondingSelectors;

const AppKit_NSControl = @import("./AppKit/NSControl/frontend.zig");
pub const NSControl = AppKit_NSControl.NSControl;
pub const NSControlTextEditingDelegate = AppKit_NSControl.NSControlTextEditingDelegate;

const AppKit_NSView = @import("./AppKit/NSView/frontend.zig");
pub const NSView = AppKit_NSView.NSView;

const AppKit_NSTextField = @import("./AppKit/NSTextField/frontend.zig");
pub const NSTextField = AppKit_NSTextField.NSTextField;
pub const NSTextFieldDelegate = AppKit_NSTextField.NSTextFieldDelegate;

const AppKit_NSTextStorage = @import("./AppKit/NSTextStorage/frontend.zig");
pub const NSTextStorage = AppKit_NSTextStorage.NSTextStorage;

const AppKit_NSText = @import("./AppKit/NSText/frontend.zig");
pub const NSTextAlignment = AppKit_NSText.NSTextAlignment;
pub const NSText = AppKit_NSText.NSText;
pub const NSTextDelegate = AppKit_NSText.NSTextDelegate;

const AppKit_NSTextView = @import("./AppKit/NSTextView/frontend.zig");
pub const NSTextView = AppKit_NSTextView.NSTextView;
pub const NSTextViewDelegate = AppKit_NSTextView.NSTextViewDelegate;

const AppKit_NSButton = @import("./AppKit/NSButton/frontend.zig");
pub const NSButton = AppKit_NSButton.NSButton;

const AppKit_NSComboBox = @import("./AppKit/NSComboBox/frontend.zig");
pub const NSComboBox = AppKit_NSComboBox.NSComboBox;
pub const NSComboBoxDelegate = AppKit_NSComboBox.NSComboBoxDelegate;
pub const NSComboBoxDataSource = AppKit_NSComboBox.NSComboBoxDataSource;

const AppKit_NSAlert = @import("./AppKit/NSAlert/frontend.zig");
pub const NSAlert = AppKit_NSAlert.NSAlert;
pub const NSAlertSelectors = @import("./AppKit/NSAlert/backend.zig").NSAlertSelectors;
