package src.foodfactory;

import src.food.Food;
import src.food.FoodName;

public interface FoodFactory {
    Food getFood(FoodName... foodNames) throws IllegalStateException;
}
