package client;

import characterfilecalculator.CharacterFileCalculator;
import characterfilecalculator.CharacterFileCalculatorAdapter;
import numberfilecalculator.NumberFileCalculator;
import numberfilecalculator.SimpleNumberFileCalculator;

import java.io.IOException;

public class Client {
    public static void main(String[] args) throws IOException {
        NumberFileCalculator nfc = new SimpleNumberFileCalculator();
        System.out.println("sum in num.txt: " + nfc.calculateSum("num.txt"));
        CharacterFileCalculator cfc = new CharacterFileCalculatorAdapter(nfc);
        System.out.println("sum in char.txt: " + cfc.calculateAsciiSum("char.txt"));
    }
}
