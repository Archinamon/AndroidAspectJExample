package com.archinamon.xpoint;

/**
 * TODO: Add destription
 *
 * @author archinamon on 12/05/16.
 */
privileged aspect TestMutator {

    pointcut mutate():
        within(com.archinamon.test.*) &&
        call(String *(..));

    String around(): mutate() {
        return "mutable";
    }
}
