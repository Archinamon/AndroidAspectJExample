package com.archinamon.example;

import android.app.Application;
import android.content.SharedPreferences;

import com.archinamon.example.dagger.AndroidAppModule;
import com.archinamon.example.dagger.DaggerTestComponent;
import com.archinamon.example.dagger.MyAppScopeModule;
import com.archinamon.example.dagger.TestComponent;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static com.archinamon.example.BuildConfig.APPLICATION_ID;

/**
 * Created by Archinamon on 10/5/15.
 */
public class MyApplication extends Application {

    public static final String LANG_KEY = "k_lang";

    private SharedPreferences mPreferences;
    private TestComponent mTestComponent;

    @Override
    public void onCreate() {
        super.onCreate();

        mPreferences = getSharedPreferences(APPLICATION_ID, MODE_PRIVATE);

        mTestComponent = DaggerTestComponent.builder()
                                            .androidAppModule(new AndroidAppModule())
                                            .myAppScopeModule(new MyAppScopeModule())
                                            .build();
        AndroidAppModule sharedAppModule = new AndroidAppModule();
    }

    public SharedPreferences getPreferences() {
        return mPreferences;
    }

    protected TestComponent getTestCpmponent() {
        return mTestComponent;
    }
}
