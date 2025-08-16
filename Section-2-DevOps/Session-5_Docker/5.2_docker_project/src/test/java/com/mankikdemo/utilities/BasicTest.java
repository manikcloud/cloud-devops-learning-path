package com.mankikdemo.utilities;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Basic test for Address Book utilities
 */
public class BasicTest extends TestCase {
    
    /**
     * Create the test case
     */
    public BasicTest(String testName) {
        super(testName);
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite() {
        return new TestSuite(BasicTest.class);
    }

    /**
     * Basic test
     */
    public void testBasic() {
        assertTrue(true);
    }
}
