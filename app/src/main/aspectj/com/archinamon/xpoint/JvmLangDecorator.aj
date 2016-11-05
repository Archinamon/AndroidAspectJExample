package com.archinamon.xpoint;

import android.content.Context;
import com.archinamon.example.BuildConfig;
import com.archinamon.example.MainActivity;
import com.archinamon.grooid.Example;
import com.archinamon.kotlin.InfoActivity;
import com.archinamon.kotlin.ToastHelperKt;

/**
 * Created by archinamon on 19/02/16.
 */
privileged aspect JvmLangDecorator {

    /* Groovy section */

    private pointcut toastInjectGrv(Context ctx): this(ctx) && within(MainActivity) && call(private void toastFromGroovy());

    void around(Context ctx): toastInjectGrv(ctx) {
        Example.sendToast(ctx);
    }

    /* Kotlin section */

    private boolean InfoActivity.inject = BuildConfig.DEBUG;

    pointcut kotlinImplicitInjector(InfoActivity activity): this(activity) && within(InfoActivity) && call(!private * *(..));
    private pointcut toastInjectKt(Context ctx): this(ctx) && within(MainActivity) && call(private void toastFromKotlin());

    after(InfoActivity activity) returning: kotlinImplicitInjector(activity) {
        if (activity.inject) {
            final String target = thisJoinPoint.toString();
            System.out.println(String.format("Aspected kotlin JP{%s} was successfully executed!", target));
        }
    }

    void around(Context ctx): toastInjectKt(ctx) {
        ToastHelperKt.sendToast(ctx);
    }
}
