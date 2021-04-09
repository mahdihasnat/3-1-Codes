package src.pizza;

public class VeggiePizza extends Pizza {
    @Override
    public int getPrice() {
        return 200;
    }

    @Override
    public String toString() {
        return "VeggiePizza";
    }
}
