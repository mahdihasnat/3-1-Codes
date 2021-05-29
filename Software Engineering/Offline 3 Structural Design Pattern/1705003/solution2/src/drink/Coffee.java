package src.drink;

import src.food.Food;
import src.pizza.Pizza;

public class Coffee extends Drink {
    public Coffee(Food food) {
        super(food);
    }

    @Override
    public int getPrice() {
        return 60 + super.getPrice();
    }

    @Override
    public String toString() {
        return "Coffee with "+super.toString();
    }
}
