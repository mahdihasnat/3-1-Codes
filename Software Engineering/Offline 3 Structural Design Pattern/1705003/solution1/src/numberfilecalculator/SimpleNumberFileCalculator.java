package numberfilecalculator;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;

public class SimpleNumberFileCalculator implements NumberFileCalculator {
    @Override
    public int calculateSum(String fileName) throws FileNotFoundException {
        File file = new File(fileName);
        Scanner scanner = new Scanner(file);
        int sum = 0;
        while (scanner.hasNext()) {
            if (scanner.hasNextInt())
                sum = sum + scanner.nextInt();
            else scanner.next();
        }
        scanner.close();
        return sum;
    }
}
