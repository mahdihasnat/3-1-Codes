package src.client;


import src.food.Food;
import src.food.FoodName;
import src.foodfactory.FoodFactory;
import src.foodfactory.SimpleFoodFactory;

public class Client {
    public static void main(String[] args) {
        /*
        1. Beef Pizza with French fry
        2. Veggie Pizza with onion rings
        3. A combo meal with Veggie Pizza, French Fry and Coke
        4. A combo meal with Veggie Pizza, Onion Rings and Coffee
        5. A Beef Pizza only
         */

        FoodFactory foodFactory = new SimpleFoodFactory();

        Food pizza = foodFactory.getFood(FoodName.BeefPizza, FoodName.FrenchFries);
        System.out.println(pizza + " $" + pizza.getPrice());

        pizza = foodFactory.getFood(FoodName.VeggiePizza, FoodName.OnionRings);
        System.out.println(pizza + " $" + pizza.getPrice());

        pizza = foodFactory.getFood(FoodName.VeggiePizza, FoodName.FrenchFries, FoodName.Coke);
        System.out.println(pizza + " $" + pizza.getPrice());

        pizza = foodFactory.getFood(FoodName.VeggiePizza, FoodName.OnionRings, FoodName.Coffee);
        System.out.println(pizza + " $" + pizza.getPrice());

        pizza = foodFactory.getFood(FoodName.BeefPizza);
        System.out.println(pizza + " $" + pizza.getPrice());

    }
}
