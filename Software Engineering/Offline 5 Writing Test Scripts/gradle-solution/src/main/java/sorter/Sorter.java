package sorter;

import java.util.List;

public interface Sorter {

    <T extends Comparable> List<T> sort(List<T> arr);

    default <T extends Comparable> void swap(List<T> arr, int i, int j) {
        T var = arr.get(i);
        arr.set(i, arr.get(j));
        arr.set(j, var);
    }
}
