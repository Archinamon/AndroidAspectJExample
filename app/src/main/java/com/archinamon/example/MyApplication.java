package com.archinamon.example;

import android.app.Application;
import android.content.SharedPreferences;

import com.archinamon.example.dagger.AndroidAppModule;
import com.archinamon.example.dagger.Injector;
import com.archinamon.example.dagger.MyAppScopeModule;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import dagger.ObjectGraph;

import static com.archinamon.example.BuildConfig.APPLICATION_ID;

/**
 * Created by Archinamon on 10/5/15.
 */
public class MyApplication extends Application implements Injector {

    public static final String LANG_KEY = "k_lang";

    private SharedPreferences mPreferences;
    private ObjectGraph mObjectGraph;

    @Override
    public void onCreate() {
        super.onCreate();

        mPreferences = getSharedPreferences(APPLICATION_ID, MODE_PRIVATE);

        AndroidAppModule sharedAppModule = new AndroidAppModule();

        // bootstrap. So that it allows no-arg constructor in AndroidAppModule
        sharedAppModule.sApplicationContext = this.getApplicationContext();

        List<Object> modules = new ArrayList<Object>();
        modules.add(sharedAppModule);
        //modules.add(new UserAccountModule());
        //modules.add(new ThreadingModule());
        modules.addAll(getAppModules());

        mObjectGraph = ObjectGraph.create(modules.toArray());

        mObjectGraph.inject(this);
    }

    public SharedPreferences getPreferences() {
        return mPreferences;
    }



    protected List<Object> getAppModules() {
        return Collections.<Object>singletonList(new MyAppScopeModule());
    }

    @Override
    public void inject(Object object) {
        mObjectGraph.inject(object);
    }

    @Override
    public ObjectGraph getObjectGraph() {
        return mObjectGraph;
    }
}
