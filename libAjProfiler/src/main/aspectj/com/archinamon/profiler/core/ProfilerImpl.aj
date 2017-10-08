package com.archinamon.profiler.core;

/**
 * Created by Archinamon on 10/18/15.
 */
aspect ProfilerImpl extends Profiler {

    private pointcut strict(): within(com.archinamon.**) && !within(*.profiler.**);

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