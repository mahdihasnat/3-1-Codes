package src.pizza;

public class Coke extends PizzaDecorator {
    public Coke(Pizza pizza) {
        super(pizza);
    }

    @Override
    public int getPrice() {
        return 50 + pizza.getPrice();
    }

    @Override
    public String toString() {
        return "Coke{" +
                "pizza=" + pizza +
                '}';
    }
}
