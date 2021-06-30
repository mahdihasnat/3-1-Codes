import sorter.BubbleSorter;
import sorter.Sorter;

public class Main {

    public static void main(String[] args) {
	    Integer [] a = { 1, 2 , 6 , 3 , 4};
        Sorter s = new BubbleSorter< Integer >();
        Integer [] sorted = (Integer[]) s.sort(a);

        for(int i: sorted)
            System.out.printf("%d ",i);
    }
}
