package src.appetizer;

import src.food.Food;

public class OnionRings extends Appetizer {

    public OnionRings(Food food) {
        super(food);
    }

    @Override
    public String toString() {
        return "OnionRings with "+super.toString();
    }
}
