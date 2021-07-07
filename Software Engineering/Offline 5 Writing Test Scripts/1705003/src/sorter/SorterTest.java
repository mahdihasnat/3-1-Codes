package sorter;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.RepeatedTest;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class SorterTest {

    // add Junit configuration and specify class name in config
    // add junit in classpath
    // setup sdk as java 11

    Sorter sorter;

    List<Integer> input;
    List<Integer> output;


    @BeforeEach
    void setUp() {
        sorter = new BubbleSorter();
    }

    @Test
    void blankList() {
        input = new ArrayList<>();
    }

    @Test
    void oneNumber() {
        input = new ArrayList<>();
        input.add(123);
    }

    @Test
    void twoNumber() {
        input = new ArrayList<>();
        input.add(2);
        input.add(1);
    }


    @RepeatedTest(10)
    void randomSized() {
        Random random = new Random();
        int n = random.nextInt(1000);

        Integer[] arr = new Integer[n];
        for (int i = 0; i < n; i++)
            arr[i] = random.nextInt();

        input = Arrays.asList(arr);

    }

    @RepeatedTest(10)
    void randomNumber() {
        Random random = new Random();
        int n = 511;

        Integer[] arr = new Integer[n];
        for (int i = 0; i < n; i++)
            arr[i] = random.nextInt();

        input = Arrays.asList(arr);
    }

    @RepeatedTest(5)
    void sortedAscending() {
        Random random = new Random();
        int n = random.nextInt(1000) + 2;

        Integer[] arr = new Integer[n];
        for (int i = 0; i < n; i++)
            arr[i] = -500 + i;

        input = Arrays.asList(arr);
    }

    @RepeatedTest(5)
    void sortedDescending() {
        Random random = new Random();
        int n = random.nextInt(1000) + 2;

        Integer[] arr = new Integer[n];
        for (int i = 0; i < n; i++)
            arr[i] = n - i + 100;

        input = Arrays.asList(arr);
    }

    @RepeatedTest(5)
    void equalNumber() {
        Random random = new Random();
        int n = random.nextInt(1000) + 2;

        Integer[] arr = new Integer[n];
        for (int i = 0; i < n; i++)
            arr[i] = n - 100;

        input = Arrays.asList(arr);
    }

    @Test
    void nullList() {
        input = null;
    }

    @RepeatedTest(10)
    void bigNumbers() {
        Random random = new Random();
        int n = random.nextInt(1000) + 10;

        Integer[] arr = new Integer[n];
        for (int i = 0; i < 5; i++) arr[i] = Integer.MAX_VALUE - i;
        for (int i = 5; i < 10; i++) arr[i] = Integer.MIN_VALUE + (i - 5);

        for (int i = 10; i < n; i++) arr[i] = Integer.MAX_VALUE / random.nextInt() * (-1 + 2 * (random.nextInt() % 2));

        input = Arrays.asList(arr);
    }

    @RepeatedTest(10)
    void smallNumbers() {
        Random random = new Random();
        int n = random.nextInt(1000) + 5;

        Integer[] arr = new Integer[n];
        for (int i = 0; i < n; i++)
            arr[i] = -n / 2 + i;

        input = Arrays.asList(arr);
    }


    void checkIfNotAltered(int n) {

        boolean[] found = new boolean[n];
        for (int i = 0; i < n; i++)
            found[i] = false;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (!found[j] && output.get(i).equals(input.get(j))) {
                    found[j] = true;
                    break;
                }
            }
        }
        for (int i = 0; i < n; i++)
            assertTrue(found[i]);
    }

    void checkIfSorted(int n) {
        for (int i = 1; i < n; i++)
            assertTrue(output.get(i) >= output.get(i - 1));
    }


    @AfterEach
    void tearDown() {


        int n;
        if (input != null) {
            n = input.size();
            output = new ArrayList<>(input);
        } else {
            n = 0;
            output = null;
        }
        output = sorter.sort(output);

        if (input != null)
            assertEquals(n, output.size());

        checkIfNotAltered(n);
        checkIfSorted(n);
    }


}