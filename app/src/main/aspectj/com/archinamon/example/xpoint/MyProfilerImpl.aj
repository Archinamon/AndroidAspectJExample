package com.archinamon.example.xpoint;

/**
 * Created by Archinamon on 10/18/15.
 */
aspect MyProfilerImpl extends Profiler {

    private pointcut strict(): within(com.archinamon.example.*) && !within(*.xpoint.*);

    pointcut innerExecution(): strict() && execution(!public !static * *(..));
    pointcut constructorCall(): strict() && call(*.new(..));
    pointcut publicExecution(): strict() && execution(public !static * *(..));
    pointcut staticsOnly(): strict() && execution(static * *(..));

    private pointcut catchAny(): innerExecution() || constructorCall() || publicExecution() || staticsOnly();

    before(): catchAny() {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(): catchAny() {
        writeExitTime(thisJoinPointStaticPart);
    }
}