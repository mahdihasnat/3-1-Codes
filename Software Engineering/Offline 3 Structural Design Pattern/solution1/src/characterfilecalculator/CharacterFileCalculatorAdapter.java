package characterfilecalculator;

import numberfilecalculator.NumberFileCalculator;

import java.io.*;
import java.util.Scanner;

public class CharacterFileCalculatorAdapter implements CharacterFileCalculator {
    NumberFileCalculator numberFileCalculator;

    public CharacterFileCalculatorAdapter(NumberFileCalculator numberFileCalculator) {
        this.numberFileCalculator = numberFileCalculator;
    }

    private void convertAsciiToNumberFile(File sourceFile, File destinationFile) throws IOException {

        Scanner scanner = new Scanner(sourceFile);
        FileWriter fileWriter = new FileWriter(destinationFile);

        boolean firstCharacter = true;
        while (scanner.hasNext()) {
            if (!firstCharacter)
                fileWriter.write(" ");

            int character = scanner.next().charAt(0);
            fileWriter.write(String.valueOf(character));

            firstCharacter = false;
        }

        scanner.close();
        fileWriter.close();
    }

    @Override
    public int calculateAsciiSum(String fileName) throws IOException {
        File file = new File(fileName);

        File tempfile = File.createTempFile("newtempfile", ".txt");
        tempfile.deleteOnExit();

        convertAsciiToNumberFile(file, tempfile);

        //System.out.println("tempfile: " +  tempfile.getAbsolutePath() );
        return numberFileCalculator.calculateSum(tempfile.getAbsolutePath());

    }
}
