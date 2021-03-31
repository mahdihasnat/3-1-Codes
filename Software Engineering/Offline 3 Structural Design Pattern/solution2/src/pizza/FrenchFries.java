package src.pizza;

public class FrenchFries extends PizzaDecorator {
    public FrenchFries(Pizza pizza) {
        super(pizza);
    }

    @Override
    public int getPrice() {
        return 100 + pizza.getPrice();
    }

    @Override
    public String toString() {
        return "FrenchFries{" +
                "pizza=" + pizza +
                '}';
    }
}
