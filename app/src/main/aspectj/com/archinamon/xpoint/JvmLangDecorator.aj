package com.archinamon.xpoint;

import com.archinamon.example.BuildConfig;
import com.archinamon.grooid.Example;
import com.archinamon.example.MyApplication;
import com.archinamon.kotlin.InfoActivity;

/**
 * Created by archinamon on 19/02/16.
 */
privileged aspect JvmLangDecorator {

    /* Groovy section */

    String MyApplication.mGroovyTestStr = "autoru_abcTest";

    pointcut groovyTestAccessToField(): within(Example) && get(* Example.abc);

    pointcut injectGroovy(): within(MyApplication) && execution(* *.onCreate(..));

    after(): injectGroovy() {
        MyApplication self = (MyApplication) thisJoinPoint.getThis();
        Example.setAbc(self.mGroovyTestStr);
        Example.main();
    }

    before(): groovyTestAccessToField() {
        Example.setAbc("1234567890");
    }

    after() returning(String value): groovyTestAccessToField() {
        Example.abc = value.charAt(5);
    }

    /* Kotlin section */

    private boolean InfoActivity.inject = BuildConfig.DEBUG;

    pointcut kotlinImplicitInjector(InfoActivity activity): this(activity) && within(InfoActivity) && call(!private * *(..));

    after(InfoActivity activity) returning: kotlinImplicitInjector(activity) {
        if (activity.inject) {
            final String target = thisJoinPoint.toString();
            System.out.println(String.format("Aspected kotlin JP{%s} was successfully executed!", target));
        }
    }
}
