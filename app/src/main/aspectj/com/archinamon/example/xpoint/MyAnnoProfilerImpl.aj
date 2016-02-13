package com.archinamon.example.xpoint;

import com.archinamon.example.profiler.ProfileCall;
import com.archinamon.example.profiler.ProfileClass;
import com.archinamon.example.profiler.ProfileDynamic;
import com.archinamon.example.profiler.ProfileErrors;
import com.archinamon.example.profiler.ProfileExecution;
import com.archinamon.example.profiler.ProfileField;
import com.archinamon.example.profiler.ProfileInstance;
import com.archinamon.example.profiler.ProfileStatic;

/**
 * Created by archinamon on 13/02/16.
 */
public aspect MyAnnoProfilerImpl extends AnnoProfiler {

    // !!!IMPORTANT!!! you can target profiler on concrete class or package
    // by changing within() NamePattern signature below
    protected pointcut strict(): within(com.archinamon.example.*) && AnnoProfiler.withoutMe();

    /* PROFILE ANNOTATED METHOD CALL */

    before(ProfileCall pc): strict() && Profiler.profileTargetCall(pc) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileCall pc): strict() && Profiler.profileTargetCall(pc) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED METHOD'S BODY EXECUTION */

    before(ProfileExecution pe): strict() && Profiler.profileTargetExecution(pe) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileExecution pe): strict() && Profiler.profileTargetExecution(pe) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' STATIC METHODS EXECUTION */

    before(ProfileClass pc): strict() && Profiler.profileTargetClass(pc) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileClass pc): strict() && Profiler.profileTargetClass(pc) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' INSTANCE METHODS EXECUTION */

    before(ProfileInstance pi): strict() && Profiler.profileTargetInstance(pi) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileInstance pi): strict() && Profiler.profileTargetInstance(pi) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' CONSTRUCTORS, SUPER-CALLS AND DYNAMIC BLOCKS */

    before(ProfileDynamic dp): strict() && Profiler.profileTargetDynamic(dp) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileDynamic dp): strict() && Profiler.profileTargetDynamic(dp) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' STATIC BLOCKS */

    before(ProfileStatic ps): strict() && Profiler.profileTargetStatic(ps) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileStatic ps): strict() && Profiler.profileTargetStatic(ps) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' FIELDS
        SUCH CLASS SHOULD BE ANNOTATED AS @ProfileClass or @ProfileInstance
        THAT DEPENDS ON WHAT KIND OF FIELD YOU WANNA PROFILE */

    before(ProfileField pf): strict() && Profiler.profileTargetField(pf) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileField pf): strict() && Profiler.profileTargetField(pf) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' OR SEPARATELY MARKED METHODS WITH ERROR HANDLER */

    Object around(ProfileErrors pe): strict() && Profiler.profileTargetErrors(pe) {
        try {
            writeEnterTime(thisJoinPointStaticPart);
            Object o = proceed(pe);
            writeExitTime(thisJoinPointStaticPart);

            return o;
        } catch (Throwable all) {
            if (AnnoProfiler.checkErrorClausing(all, pe))
                writeException(thisJoinPointStaticPart, all);
            removeEnterTime(thisJoinPointStaticPart);
        }
    }
}
