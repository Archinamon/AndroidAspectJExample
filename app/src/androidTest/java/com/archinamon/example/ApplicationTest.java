package com.archinamon.example;

import android.content.Intent;
import android.support.test.InstrumentationRegistry;
import android.support.test.rule.ActivityTestRule;
import android.support.test.runner.AndroidJUnit4;
import com.archinamon.kotlin.InfoActivity;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

/**
 * <a href="http://d.android.com/tools/testing/testing_android.html">Testing Fundamentals</a>
 */
@RunWith(AndroidJUnit4.class)
public class ApplicationTest {

    @Rule
    public ActivityTestRule<InfoActivity> infoActivityRule = new ActivityTestRule<>(InfoActivity.class, false, true);

    @Test
    public void emptyTest() {
        infoActivityRule.launchActivity(new Intent(InstrumentationRegistry.getContext(), InfoActivity.class));
    }
}