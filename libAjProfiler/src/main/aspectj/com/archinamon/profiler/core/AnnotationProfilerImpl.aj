package com.archinamon.profiler.core;

import com.archinamon.profiler.annotation.ProfileCall;
import com.archinamon.profiler.annotation.ProfileClass;
import com.archinamon.profiler.annotation.ProfileDynamic;
import com.archinamon.profiler.annotation.ProfileErrors;
import com.archinamon.profiler.annotation.ProfileExecution;
import com.archinamon.profiler.annotation.ProfileField;
import com.archinamon.profiler.annotation.ProfileInstance;
import com.archinamon.profiler.annotation.ProfileStatic;

/**
 * Created by archinamon on 13/02/16.
 */
public aspect AnnotationProfilerImpl extends AnnotationProfiler {

    /* PROFILE ANNOTATED METHOD CALL */

    before(ProfileCall pc): AnnotationProfiler.profileTargetCall(pc) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileCall pc): AnnotationProfiler.profileTargetCall(pc) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED METHOD'S BODY EXECUTION */

    before(ProfileExecution pe): AnnotationProfiler.profileTargetExecution(pe) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileExecution pe): AnnotationProfiler.profileTargetExecution(pe) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' STATIC METHODS EXECUTION */

    before(ProfileClass pc): AnnotationProfiler.profileTargetClass(pc) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileClass pc): AnnotationProfiler.profileTargetClass(pc) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' INSTANCE METHODS EXECUTION */

    before(ProfileInstance pi): AnnotationProfiler.profileTargetInstance(pi) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileInstance pi): AnnotationProfiler.profileTargetInstance(pi) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' CONSTRUCTORS, SUPER-CALLS AND DYNAMIC BLOCKS */

    before(ProfileDynamic dp): AnnotationProfiler.profileTargetDynamic(dp) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileDynamic dp): AnnotationProfiler.profileTargetDynamic(dp) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' STATIC BLOCKS */

    before(ProfileStatic ps): AnnotationProfiler.profileTargetStatic(ps) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileStatic ps): AnnotationProfiler.profileTargetStatic(ps) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' FIELDS
        SUCH CLASS SHOULD BE ANNOTATED AS @ProfileClass or @ProfileInstance
        THAT DEPENDS ON WHAT KIND OF FIELD YOU WANNA PROFILE */

    before(ProfileField pf): AnnotationProfiler.profileTargetField(pf) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileField pf): AnnotationProfiler.profileTargetField(pf) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' OR SEPARATELY MARKED METHODS WITH ERROR HANDLER */

    Object around(ProfileErrors pe): AnnotationProfiler.profileTargetErrors(pe) {
        try {
            writeEnterTime(thisJoinPointStaticPart);
            Object o = proceed(pe);
            writeExitTime(thisJoinPointStaticPart);

            return o;
        } catch (Throwable all) {
            if (checkErrorClausing(all, pe))
                writeException(thisJoinPointStaticPart, all);
            removeEnterTime(thisJoinPointStaticPart);

            return null;
        }
    }
}
