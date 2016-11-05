package com.archinamon.xpoint;

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

    /* PROFILE ANNOTATED METHOD CALL */

    before(ProfileCall pc): AnnoProfiler.profileTargetCall(pc) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileCall pc): AnnoProfiler.profileTargetCall(pc) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED METHOD'S BODY EXECUTION */

    before(ProfileExecution pe): AnnoProfiler.profileTargetExecution(pe) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileExecution pe): AnnoProfiler.profileTargetExecution(pe) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' STATIC METHODS EXECUTION */

    before(ProfileClass pc): AnnoProfiler.profileTargetClass(pc) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileClass pc): AnnoProfiler.profileTargetClass(pc) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' INSTANCE METHODS EXECUTION */

    before(ProfileInstance pi): AnnoProfiler.profileTargetInstance(pi) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileInstance pi): AnnoProfiler.profileTargetInstance(pi) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' CONSTRUCTORS, SUPER-CALLS AND DYNAMIC BLOCKS */

    before(ProfileDynamic dp): AnnoProfiler.profileTargetDynamic(dp) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileDynamic dp): AnnoProfiler.profileTargetDynamic(dp) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' STATIC BLOCKS */

    before(ProfileStatic ps): AnnoProfiler.profileTargetStatic(ps) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileStatic ps): AnnoProfiler.profileTargetStatic(ps) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' FIELDS
        SUCH CLASS SHOULD BE ANNOTATED AS @ProfileClass or @ProfileInstance
        THAT DEPENDS ON WHAT KIND OF FIELD YOU WANNA PROFILE */

    before(ProfileField pf): AnnoProfiler.profileTargetField(pf) {
        writeEnterTime(thisJoinPointStaticPart);
    }

    after(ProfileField pf): AnnoProfiler.profileTargetField(pf) {
        writeExitTime(thisJoinPointStaticPart);
    }

    /* PROFILE ANNOTATED CLASS' OR SEPARATELY MARKED METHODS WITH ERROR HANDLER */

    Object around(ProfileErrors pe): AnnoProfiler.profileTargetErrors(pe) {
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
