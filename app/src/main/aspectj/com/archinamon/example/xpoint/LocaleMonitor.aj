package com.archinamon.example.xpoint;

import android.app.AlarmManager;
import android.app.Application;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import com.archinamon.example.MyApplication;
import java.util.Locale;

import static android.content.Context.MODE_PRIVATE;
import static com.archinamon.example.BuildConfig.APPLICATION_ID;

/**
 * Created by Archinamon on 10/6/15.
 */
aspect LocaleMonitor {

    /* inter-type declaration
       injecting instance-field and getter/setter methods into MyApplication class */

    private static Application MyApplication.sInstance;

    // method declared as package-local
    // only aspect classes within package .xpoint will have access to these methods
    static void MyApplication.setInstance(@NonNull Application inst) {
        sInstance = inst;
    }

    static Application MyApplication.getInstance() {
        return sInstance;
    }

    /* end of inter-type declaration */

    private static final String LANG_RAW_KEY = "aj_lang_val";

    pointcut saveLocale(): execution(* MyApplication.onCreate());
    pointcut checkLocale(AppCompatActivity activity): this(activity) && execution(* AppCompatActivity+.onCreate(..));

    after(): saveLocale() {
        final MyApplication app = (MyApplication) thisJoinPoint.getThis();
        MyApplication.setInstance(app);
        saveCurrentLocale();
    }

    after(AppCompatActivity activity): checkLocale(activity) {
        if (isLocaleChanged()) {
            saveCurrentLocale();
            restartApplication(activity);
        }
    }

    void saveCurrentLocale() {
        getPreferences().edit()
                        .putString(LANG_RAW_KEY, Locale.getDefault().toString())
                        .putString(MyApplication.LANG_KEY, Locale.getDefault().getDisplayLanguage())
                        .apply();
    }

    void restartApplication(AppCompatActivity context) {
        Intent i = new Intent(context, context.getClass());
        PendingIntent launch = PendingIntent.getActivity(context, 0, i, PendingIntent.FLAG_ONE_SHOT);

        AlarmManager am = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        am.set(AlarmManager.RTC, System.currentTimeMillis() + 1000, launch);

        context.finish();
    }

    boolean isLocaleChanged() {
        final String savedLocale = getPreferences().getString(LANG_RAW_KEY, "");
        final String currentLocale = Locale.getDefault().toString();

        return !currentLocale.equalsIgnoreCase(savedLocale);
    }

    private SharedPreferences getPreferences() {
        return MyApplication.getInstance()
                            .getSharedPreferences(APPLICATION_ID, MODE_PRIVATE);
    }
}