package com.archinamon.xpoint;

import com.archinamon.example.profiler.ProfileCall;
import com.archinamon.example.profiler.ProfileClass;
import com.archinamon.example.profiler.ProfileDynamic;
import com.archinamon.example.profiler.ProfileErrors;
import com.archinamon.example.profiler.ProfileExecution;
import com.archinamon.example.profiler.ProfileField;
import com.archinamon.example.profiler.ProfileInstance;
import com.archinamon.example.profiler.ProfileStatic;
import org.aspectj.lang.JoinPoint;
import java.util.Arrays;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import static java.lang.System.out;

/**
 * Created by archinamon on 13/02/16.
 */
abstract aspect AnnoProfiler {

    abstract protected pointcut strict();
    protected final pointcut withoutMe(): !within(*.xpoint.*);

    // this line declares execution order according to advice execution rules
    // this aspect should run over all others
    declare precedence: AnnoProfiler+, *;

    // collect joinpoints only if defined annotations on object type is set
    private pointcut fieldOwner(): (within(@ProfileInstance *) || within(@ProfileClass *));

    // warn if profiled field breaks encapsulation
    private pointcut setFieldWarn(): @annotation(ProfileField) && set(!public * *) && !withincode(* set*(..));
    declare warning: withoutMe() && fieldOwner() && setFieldWarn()
            : "[AOP:Warning!] => writing field outside the setter";

    private pointcut getFieldWarn(): @annotation(ProfileField) && get(!public * *) && !withincode(* get*(..));
    declare warning: withoutMe() && fieldOwner() && getFieldWarn()
            : "[AOP:Warning!] => reading field outside the getter";

    protected final pointcut profileTargetCall(ProfileCall pc): call(* *(..)) && @annotation(pc);
    protected final pointcut profileTargetExecution(ProfileExecution pe): execution(* *(..)) && @annotation(pe);

    protected final pointcut profileTargetErrors(ProfileErrors pe): @annotation(pe) && (execution(* *(..)) || execution(* *(..) throws *));

    protected final pointcut profileTargetClass(ProfileClass pc): @within(pc) && execution(static * *(..));
    protected final pointcut profileTargetInstance(ProfileInstance pi): @within(pi) && execution(!static * *(..));

    protected final pointcut profileTargetDynamic(ProfileDynamic pd): @within(pd) && (preinitialization(*.new(..)) || initialization(*.new(..)));
    protected final pointcut profileTargetStatic(ProfileStatic ps): @within(ps) && staticinitialization(*);
    protected final pointcut profileTargetField(ProfileField pf): fieldOwner() && (set(* *) || get(* *)) && @annotation(pf);

    protected static boolean checkErrorClausing(Throwable throwable, ProfileErrors pe) {
        return Arrays.asList(pe.value()).contains(throwable.getClass());
    }

    protected static final Map<String, Long> sTimeData = new ConcurrentHashMap<>();

    protected void writeEnterTime(JoinPoint.StaticPart jp) {
        sTimeData.put(getIdx(jp), System.currentTimeMillis());
    }

    protected void removeEnterTime(JoinPoint.StaticPart jp) {
        final String idx = getIdx(jp);
        if (sTimeData.containsKey(idx)) sTimeData.remove(idx);
    }

    protected void writeExitTime(JoinPoint.StaticPart jp) {
        final String idx = getIdx(jp);
        if (!sTimeData.containsKey(idx)) return;

        Long finishTime = System.currentTimeMillis();
        Long startTime = sTimeData.remove(idx);

        Long timing = finishTime - startTime;
        print(idx + " takes " + timing + "ms to proceed");
    }

    protected void writeException(JoinPoint.StaticPart jp, Throwable th) {
        final String idx = getIdx(jp);
        if (!sTimeData.containsKey(idx)) return;

        Long finishTime = System.currentTimeMillis();
        Long startTime = sTimeData.remove(idx);
        Long timing = finishTime - startTime;

        print(idx + " throwed unhandled exception: " + th.getMessage());
        print(idx + " takes " + timing + " before throwing exception");
        print("below goes a stacktrace");
        th.printStackTrace();
    }

    private void print(final String data) {
        out.println(data);
    }

    private String getIdx(JoinPoint.StaticPart jp) {
        String className = jp.getSignature().getDeclaringTypeName();
        String methodName = jp.getSignature().getName();

        return className + ":" + methodName;
    }
}
