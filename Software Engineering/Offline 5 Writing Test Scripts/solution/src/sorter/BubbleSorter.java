package sorter;

public class BubbleSorter<T extends Comparable<T>> implements Sorter<T> {
    @Override
    public T[] sort(T[] array) {
        T [] sorted = array.clone();
        for(int i=0;i<sorted.length;i++)
        {
            for(int j=0;j<sorted.length-i+1;j++)
            {
                if(sorted[i].compareTo(sorted[i+j]) )
                {
                    swap(sorted , i,i+j);
                }
            }
        }
        return  sorted;
    }
}
