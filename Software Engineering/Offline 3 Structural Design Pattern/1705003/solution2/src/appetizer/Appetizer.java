package src.appetizer;

import src.food.Food;
import src.food.FoodDecorator;

public abstract class Appetizer extends FoodDecorator {
    public Appetizer(Food food) {
        super(food);
    }

    @Override
    public final int getPrice() {
        return 100 + super.getPrice();
    }

    @Override
    public String toString() {
        return super.toString();
    }
}
