const std = @import("std");

const runtime = @import("Runtime");
const foundation = @import("Foundation");
const appKit = @import("AppKit");
const coreGraphics = @import("CoreGraphics");

const NSBezierPath = appKit.NSBezierPath;
const NSBezierPathElement = appKit.NSBezierPathElement;

const CGFloat = coreGraphics.CGFloat;
const CGPathRef = coreGraphics.CGPathRef;
const CGMutablePathRef = coreGraphics.CGMutablePathRef;
const CGAffineTransform = coreGraphics.CGAffineTransform;

const NSPoint = foundation.NSPoint;

pub const NSBezierPathSupport = struct {
    pub fn toCGPath(path: NSBezierPath) CGPathRef {
        if (comptime std.meta.hasFn(NSBezierPath, "cgPath")) {
            return NSBezierPath.cgPath(path);
        } 
        else {
            return toCGPathInternal(path);
        }
    }
};

fn toCGPathInternal(path: NSBezierPath) CGPathRef {
    const result_path = coreGraphics.CGPathCreateMutable();
    var points: [3]NSPoint = undefined;
    var need_close_path = false;

    const p: foundation.NSPointArray = @ptrCast(@alignCast(&points));

    var i: runtime.NSInteger = 0;
    const len = path.elementCount();
    while (i < len) : (i += 1) {
        const path_kind = path.elementAtIndexAssociatedPoints(i, p);
        if (std.meta.eql(path_kind, NSBezierPathElement.MoveTo)) {
            // result_path.CGPathMoveToPoint(null, points[0].x, points[0].y);
            coreGraphics.CGPathMoveToPoint(result_path, null, points[0].x, points[0].y);
        } 
        else if (std.meta.eql(path_kind, NSBezierPathElement.LineTo)) {
            // result_path.CGPathAddLineToPoint(null, points[0].x, points[0].y);
            coreGraphics.CGPathAddLineToPoint(result_path, null, points[0].x, points[0].y);
            need_close_path = true;
        } 
        else if (std.meta.eql(path_kind, NSBezierPathElement.CurveTo)) {
            coreGraphics.CGPathAddCurveToPoint(result_path, null, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y);
            need_close_path = true;
        } 
        else if (std.meta.eql(path_kind, NSBezierPathElement.ClosePath)) {
            coreGraphics.CGPathCloseSubpath(result_path);
            need_close_path = false;
        }
    }

    if (need_close_path) {
        coreGraphics.CGPathCloseSubpath(result_path);
    }

    return result_path;
}
