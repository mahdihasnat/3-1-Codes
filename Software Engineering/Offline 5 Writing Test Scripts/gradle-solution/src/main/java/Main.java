
import java.util.ArrayList;
import java.util.List;

import sorter.BubbleSorter;
import sorter.Sorter;


public class Main {
    public static void main(String[] args) {
        List<Integer> a = new ArrayList<>();
        a.add(1);
        a.add(5);
        a.add(4);
        a.add(3);

        Sorter s = new BubbleSorter();
        List<Integer> sorted = s.sort(a);

        for (int i : sorted)
            System.out.printf("%d ", i);
    }
}
