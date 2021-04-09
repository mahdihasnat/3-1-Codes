package src.appetizer;

import src.food.Food;

public class FrenchFries extends Appetizer {

    public FrenchFries(Food food) {
        super(food);
    }

    @Override
    public String toString() {
        return "FrenchFries with "+super.toString();
    }
}
