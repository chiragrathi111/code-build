package org.example;

import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Calculator Tests")
class CalculatorTest {

    private Calculator calc;

    @BeforeEach
    void setUp() {
        calc = new Calculator(); // runs fresh before each test
    }

    @Test
    @DisplayName("3 + 5 = 8")
    void testAdd() {
        assertEquals(8, calc.add(3, 5));
    }

    @Test
    @DisplayName("10 - 4 = 6")
    void testSubtract() {
        assertEquals(6, calc.subtract(10, 4));
    }

    @Test
    @DisplayName("3 x 4 = 12")
    void testMultiply() {
        assertEquals(12, calc.multiply(3, 4));
    }

    @Test
    @DisplayName("10 / 2 = 5.0")
    void testDivide() {
        assertEquals(5.0, calc.divide(10, 2));
    }

    @Test
    @DisplayName("Divide by zero throws exception")
    void testDivideByZero() {
        IllegalArgumentException ex = assertThrows(
                IllegalArgumentException.class,
                () -> calc.divide(5, 0)
        );
        assertEquals("Cannot divide by zero!", ex.getMessage());
    }
}