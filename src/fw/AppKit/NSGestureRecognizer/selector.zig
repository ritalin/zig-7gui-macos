const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSGestureRecognizerSelectors = struct {
    pub fn initWithTargetAction() objc.Sel {
        if (_sel_initWithTargetAction == null) {
            _sel_initWithTargetAction = objc.Sel.registerName("initWithTarget:action:");
        }
        return _sel_initWithTargetAction.?;
    }

    pub fn target() objc.Sel {
        if (_sel_target == null) {
            _sel_target = objc.Sel.registerName("target");
        }
        return _sel_target.?;
    }

    pub fn setTarget() objc.Sel {
        if (_sel_setTarget == null) {
            _sel_setTarget = objc.Sel.registerName("setTarget:");
        }
        return _sel_setTarget.?;
    }

    pub fn action() objc.Sel {
        if (_sel_action == null) {
            _sel_action = objc.Sel.registerName("action");
        }
        return _sel_action.?;
    }

    pub fn setAction() objc.Sel {
        if (_sel_setAction == null) {
            _sel_setAction = objc.Sel.registerName("setAction:");
        }
        return _sel_setAction.?;
    }

    pub fn state() objc.Sel {
        if (_sel_state == null) {
            _sel_state = objc.Sel.registerName("state");
        }
        return _sel_state.?;
    }

    pub fn delegate() objc.Sel {
        if (_sel_delegate == null) {
            _sel_delegate = objc.Sel.registerName("delegate");
        }
        return _sel_delegate.?;
    }

    pub fn setDelegate() objc.Sel {
        if (_sel_setDelegate == null) {
            _sel_setDelegate = objc.Sel.registerName("setDelegate:");
        }
        return _sel_setDelegate.?;
    }

    pub fn pressureConfiguration() objc.Sel {
        if (_sel_pressureConfiguration == null) {
            _sel_pressureConfiguration = objc.Sel.registerName("pressureConfiguration");
        }
        return _sel_pressureConfiguration.?;
    }

    pub fn setPressureConfiguration() objc.Sel {
        if (_sel_setPressureConfiguration == null) {
            _sel_setPressureConfiguration = objc.Sel.registerName("setPressureConfiguration:");
        }
        return _sel_setPressureConfiguration.?;
    }

    pub fn locationInView() objc.Sel {
        if (_sel_locationInView == null) {
            _sel_locationInView = objc.Sel.registerName("locationInView:");
        }
        return _sel_locationInView.?;
    }

    var _sel_initWithTargetAction: ?objc.Sel = null;
    var _sel_target: ?objc.Sel = null;
    var _sel_setTarget: ?objc.Sel = null;
    var _sel_action: ?objc.Sel = null;
    var _sel_setAction: ?objc.Sel = null;
    var _sel_state: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
    var _sel_pressureConfiguration: ?objc.Sel = null;
    var _sel_setPressureConfiguration: ?objc.Sel = null;
    var _sel_locationInView: ?objc.Sel = null;
};

pub const NSTouchBarForNSGestureRecognizerSelectors = struct {};

pub const NSSubclassUseForNSGestureRecognizerSelectors = struct {};

pub const NSGestureRecognizerDelegateSelectors = struct {
    pub fn gestureRecognizerShouldAttemptToRecognizeWithEvent() objc.Sel {
        if (_sel_gestureRecognizerShouldAttemptToRecognizeWithEvent == null) {
            _sel_gestureRecognizerShouldAttemptToRecognizeWithEvent = objc.Sel.registerName("gestureRecognizer:shouldAttemptToRecognizeWithEvent:");
        }
        return _sel_gestureRecognizerShouldAttemptToRecognizeWithEvent.?;
    }

    pub fn gestureRecognizerShouldBegin() objc.Sel {
        if (_sel_gestureRecognizerShouldBegin == null) {
            _sel_gestureRecognizerShouldBegin = objc.Sel.registerName("gestureRecognizerShouldBegin:");
        }
        return _sel_gestureRecognizerShouldBegin.?;
    }

    pub fn gestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer() objc.Sel {
        if (_sel_gestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer == null) {
            _sel_gestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer = objc.Sel.registerName("gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:");
        }
        return _sel_gestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer.?;
    }

    pub fn gestureRecognizerShouldRequireFailureOfGestureRecognizer() objc.Sel {
        if (_sel_gestureRecognizerShouldRequireFailureOfGestureRecognizer == null) {
            _sel_gestureRecognizerShouldRequireFailureOfGestureRecognizer = objc.Sel.registerName("gestureRecognizer:shouldRequireFailureOfGestureRecognizer:");
        }
        return _sel_gestureRecognizerShouldRequireFailureOfGestureRecognizer.?;
    }

    var _sel_gestureRecognizerShouldAttemptToRecognizeWithEvent: ?objc.Sel = null;
    var _sel_gestureRecognizerShouldBegin: ?objc.Sel = null;
    var _sel_gestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer: ?objc.Sel = null;
    var _sel_gestureRecognizerShouldRequireFailureOfGestureRecognizer: ?objc.Sel = null;
};
