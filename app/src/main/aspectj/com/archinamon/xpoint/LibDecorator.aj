package com.archinamon.xpoint;

import android.app.Activity;
import android.widget.Toast;
import com.archinamon.example.MainActivity;
import com.archinamon.example.lib.LibExample;

/**
 * Created by archinamon on 08/10/17.
 */
privileged aspect LibDecorator {

    /* Library section */

    pointcut toastInjectLib(MainActivity activity): this(activity) && execution(* Activity.onStart(..));

    after(MainActivity activity) returning: toastInjectLib(activity) {
        final String msg = new LibExample().hello();
        Toast.makeText(activity, msg, Toast.LENGTH_LONG).show();
    }
}
