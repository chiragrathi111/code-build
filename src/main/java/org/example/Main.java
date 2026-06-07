package org.example;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        //TIP Press <shortcut actionId="ShowIntentionActions"/> with your caret at the highlighted text
        // to see how IntelliJ IDEA suggests fixing it.
//        System.out.printf("Hello and welcome!");

//        for (int i = 1; i <= 5; i++) {
//            //TIP Press <shortcut actionId="Debug"/> to start debugging your code. We have set one <icon src="AllIcons.Debugger.Db_set_breakpoint"/> breakpoint
//            // for you, but you can always add more by pressing <shortcut actionId="ToggleLineBreakpoint"/>.
//            System.out.println("i = " + i);
//        }

        // Demo: use Calculator
        Calculator calc = new Calculator();
        System.out.println("3 + 5 = " + calc.add(3, 5));
        System.out.println("10 - 4 = " + calc.subtract(10, 4));
        System.out.println("3 x 4 = " + calc.multiply(3, 4));
        System.out.println("10 / 2 = " + calc.divide(10, 2));
        System.out.println("100 / 5 = " + calc.divide(100, 5));
    }
}