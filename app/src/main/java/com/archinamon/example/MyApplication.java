package com.archinamon.example;

import android.app.Application;
import android.content.SharedPreferences;

import static com.archinamon.example.BuildConfig.APPLICATION_ID;

/**
 * Created by Archinamon on 10/5/15.
 */
public class MyApplication extends Application {

    public static final String LANG_KEY = "k_lang";

    private SharedPreferences mPreferences;

    @Override
    public void onCreate() {
        super.onCreate();

        mPreferences = getSharedPreferences(APPLICATION_ID, MODE_PRIVATE);
    }

    public SharedPreferences getPreferences() {
        return mPreferences;
    }
}
