package src.drink;

import src.food.Food;
import src.food.FoodDecorator;

public abstract class Drink extends FoodDecorator {
    public Drink(Food food) {
        super(food);
    }

    @Override
    public int getPrice() {
        return super.getPrice();
    }

    @Override
    public String toString() {
        return super.toString();
    }
}
