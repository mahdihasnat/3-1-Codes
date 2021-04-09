package src.drink;

import src.food.Food;

public class Coke extends Drink {

    public Coke(Food food) {
        super(food);
    }

    @Override
    public int getPrice() {
        return super.getPrice();
    }

    @Override
    public String toString() {
        return "Coke with " + super.toString();
    }
}
