package com.archinamon.example.xpoint;

import org.aspectj.lang.JoinPoint;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import static java.lang.System.out;

/**
 * Created by Archinamon on 10/18/15.
 */
abstract aspect Profiler issingleton() {

    abstract pointcut innerExecution();
    abstract pointcut constructorCall();
    abstract pointcut publicExecution();
    abstract pointcut staticsOnly();

    protected static final Map<String, Long> sTimeData = new ConcurrentHashMap<>();

    protected void writeEnterTime(JoinPoint.StaticPart jp) {
        sTimeData.put(getIdx(jp), System.currentTimeMillis());
    }

    protected void writeExitTime(JoinPoint.StaticPart jp) {
        String idx = getIdx(jp);
        if (!sTimeData.containsKey(idx)) return;

        Long finishTime = System.currentTimeMillis();
        Long startTime = sTimeData.remove(getIdx(jp));

        Long timing = finishTime - startTime;
        printFormattedTime(getIdx(jp) + " takes " + timing + "ms to proceed");
    }

    private void printFormattedTime(final String data) {
        out.println(data);
    }

    private String getIdx(JoinPoint.StaticPart jp) {
        String className = jp.getSignature().getDeclaringTypeName();
        String methodName = jp.getSignature().getName();

        return className + ":" + methodName;
    }
}