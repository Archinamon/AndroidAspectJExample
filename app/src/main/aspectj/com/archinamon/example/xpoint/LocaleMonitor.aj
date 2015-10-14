package com.archinamon.example.xpoint;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import com.archinamon.example.MyApplication;
import java.util.Locale;

/**
 * Created by Archinamon on 10/6/15.
 */
aspect LocaleMonitor {

    private static final String LANG_RAW_KEY = "aj_lang_val";

    pointcut saveLocale(): execution(* MyApplication.onCreate());
    pointcut checkLocale(AppCompatActivity activity): this(activity) && execution(* AppCompatActivity+.onCreate(..));

    after(): saveLocale() {
        final MyApplication app = (MyApplication) thisJoinPoint.getThis();
        saveCurrentLocale(app);
    }

    before(AppCompatActivity activity): checkLocale(activity) {
        if (isLocaleChanged(activity)) {
            final MyApplication app = (MyApplication) activity.getApplication();
            saveCurrentLocale(app);
            restartApplication(activity);
        }
    }

    void saveCurrentLocale(final MyApplication app) {
        app.getPreferences()
           .edit()
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

    boolean isLocaleChanged(AppCompatActivity context) {
        final MyApplication app = (MyApplication) context.getApplication();
        final String savedLocale = app.getPreferences().getString(LANG_RAW_KEY, "");
        final String currentLocale = Locale.getDefault().toString();

        return !currentLocale.equalsIgnoreCase(savedLocale);
    }
}