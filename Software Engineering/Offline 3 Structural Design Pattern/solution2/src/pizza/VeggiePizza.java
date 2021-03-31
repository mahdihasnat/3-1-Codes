package src.pizza;

public class VeggiePizza implements Pizza {
    @Override
    public int getPrice() {
        return 200;
    }

    @Override
    public String toString() {
        return "VeggiePizza{}";
    }
}
