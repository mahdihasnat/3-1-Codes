package sorter;

import java.util.Collections;
import java.util.List;

public class BubbleSorter implements Sorter {
    @Override
    public List<Integer> sort(List<Integer> arr) {
        if (arr == null) return null;
        int n = arr.size();
        for (int i = 0; i < n; i++) {
            for (int j = 1; j < (n - i); j++) {
                if ((arr.get(j)) < (arr.get(j - 1)))
                    Collections.swap(arr, j, j - 1);
            }
        }
        return arr;
    }
}
