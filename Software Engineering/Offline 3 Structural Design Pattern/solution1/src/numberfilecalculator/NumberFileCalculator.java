package numberfilecalculator;

import java.io.FileNotFoundException;

public interface NumberFileCalculator {
    int calculateSum(String fileName) throws FileNotFoundException;
}
