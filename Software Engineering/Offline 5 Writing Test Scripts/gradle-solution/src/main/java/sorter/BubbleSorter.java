package sorter;

import java.util.List;

public class BubbleSorter implements Sorter {
    @Override
    public <T extends Comparable> List<T> sort(List<T> arr) {
        if(arr == null) return null;
        int n = arr.size();
        for (int i = 0; i < n; i++) {
            for (int j = 1; j < (n - i); j++) {
                if (arr.get(j - 1).compareTo(arr.get(j)) > 0) {
                    //swap elements
                    swap(arr, j, j - 1);
                }
            }
        }
        return arr;
    }
}
