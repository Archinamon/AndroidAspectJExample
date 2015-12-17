package com.archinamon.example.dagger;

import com.archinamon.example.MainActivity;
import javax.inject.Singleton;
import dagger.Component;
import dagger.Module;

@Singleton
@Component(modules={AndroidAppModule.class, MyAppScopeModule.class})
public interface TestComponent {

   void inject(MainActivity activity);
}