const AppKit_NSApplication = @import("./AppKit/NSApplication/frontend.zig");
pub const NSApplication = AppKit_NSApplication.NSApplication;
pub const NSApplicationDelegate = AppKit_NSApplication.NSApplicationDelegate;

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

const AppKit_NSControl = @import("./AppKit/NSControl/frontend.zig");
pub const NSControl = AppKit_NSControl.NSControl;

const AppKit_NSView = @import("./AppKit/NSView/frontend.zig");
pub const NSView = AppKit_NSView.NSView;

const AppKit_NSTextField = @import("./AppKit/NSTextField/frontend.zig");
pub const NSTextField = AppKit_NSTextField.NSTextField;

const AppKit_NSText = @import("./AppKit/NSText/frontend.zig");
pub const NSTextAlignment = AppKit_NSText.NSTextAlignment;

const AppKit_NSButton = @import("./AppKit/NSButton/frontend.zig");
pub const NSButton = AppKit_NSButton.NSButton;