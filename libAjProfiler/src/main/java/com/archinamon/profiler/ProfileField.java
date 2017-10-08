package com.archinamon.profiler;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * Created by archinamon on 15/01/16.
 */
@Target(FIELD)
@Retention(RUNTIME)
public @interface ProfileField {}
