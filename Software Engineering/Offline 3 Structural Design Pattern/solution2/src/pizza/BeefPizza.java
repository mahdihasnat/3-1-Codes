package src.pizza;

public class BeefPizza implements Pizza {
    @Override
    public int getPrice() {
        return 250;
    }

    @Override
    public String toString() {
        return "BeefPizza{}";
    }
}
