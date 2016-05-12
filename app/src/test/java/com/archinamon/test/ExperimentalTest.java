package com.archinamon.test;

import com.archinamon.example.profiler.ProfileCall;
import org.junit.Test;

import static junit.framework.Assert.assertEquals;

/**
 * TODO: Add destription
 *
 * @author archinamon on 29/04/16.
 */
public class ExperimentalTest {

    @Test
    public void testAspectJ() {
        final String e = "exec";
        assertEquals(e, "exec");

        final int a = 123;
        assertEquals(a, 123);

        final String c = "call";
        assertEquals(c, "call");

        final String mutated = getImmutable();
        assertEquals(mutated, "mutable");
    }

    @ProfileCall
    String getImmutable() {
        return "immutable";
    }
}
