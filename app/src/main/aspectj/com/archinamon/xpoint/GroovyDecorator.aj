package com.archinamon.xpoint;

import com.archinamon.grooid.Example;
import com.archinamon.example.MyApplication;

/**
 * Created by archinamon on 19/02/16.
 */
privileged aspect GroovyDecorator {

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
        Example.main();
    }

    after() returning(String value): groovyTestAccessToField() {
        Example.abc = value.charAt(5);
        Example.main();
    }

    private void impl(Runnable i) {
        i.run();
    }
}
