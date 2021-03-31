package src.pizza;

public class OnionRings extends PizzaDecorator {
    public OnionRings(Pizza pizza) {
        super(pizza);
    }

    @Override
    public int getPrice() {
        return 100 + pizza.getPrice();
    }

    @Override
    public String toString() {
        return "OnionRings{" +
                "pizza=" + pizza +
                '}';
    }
}
