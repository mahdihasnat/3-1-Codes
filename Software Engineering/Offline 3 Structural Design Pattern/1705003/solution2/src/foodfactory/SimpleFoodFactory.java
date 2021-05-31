package src.foodfactory;

import src.appetizer.FrenchFries;
import src.appetizer.OnionRings;
import src.drink.Coffee;
import src.drink.Coke;
import src.food.Food;
import src.food.FoodName;
import src.pizza.BeefPizza;
import src.pizza.VeggiePizza;

public class SimpleFoodFactory implements FoodFactory {
    @Override
    public Food getFood(FoodName... foodNames) throws IllegalStateException {
        Food food = null;
        for (FoodName foodName : foodNames) {
            switch (foodName) {
                case VeggiePizza -> food = new VeggiePizza();
                case BeefPizza -> food = new BeefPizza();
                case Coke -> food = new Coke(food);
                case Coffee -> food = new Coffee(food);
                case OnionRings -> food = new OnionRings(food);
                case FrenchFries -> food = new FrenchFries(food);

                default -> throw new IllegalStateException("Unexpected value: " + foodName);
            }
        }
        return food;
    }
}
