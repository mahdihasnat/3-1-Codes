package src.pizza;

public class Coffee extends PizzaDecorator {
    public Coffee(Pizza pizza) {
        super(pizza);
    }


    @Override
    public int getPrice() {
        return 60 + pizza.getPrice();
    }

    @Override
    public String toString() {
        return "Coffee{" +
                "pizza=" + pizza +
                '}';
    }
}
