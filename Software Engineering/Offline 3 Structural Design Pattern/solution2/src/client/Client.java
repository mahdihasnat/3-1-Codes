package src.client;

import src.pizza.*;

public class Client {
    public static void main(String[] args) {
        /*
        1. Beef Pizza with French fry
        2. Veggie Pizza with onion rings
        3. A combo meal with Veggie Pizza, French Fry and Coke
        4. A combo meal with Veggie Pizza, Onion Rings and Coffee
        5. A Beef Pizza only
         */

        Pizza pizza = new BeefPizza();
        pizza = new FrenchFries(pizza);
        System.out.println(pizza + " $" + pizza.getPrice());

        pizza = new VeggiePizza();
        pizza = new OnionRings(pizza);
        System.out.println(pizza + " $" + pizza.getPrice());

        pizza = new VeggiePizza();
        pizza = new FrenchFries(pizza);
        pizza = new Coke(pizza);
        System.out.println(pizza + " $" + pizza.getPrice());

        pizza = new VeggiePizza();
        pizza = new OnionRings(pizza);
        pizza = new Coffee(pizza);
        System.out.println(pizza + " $" + pizza.getPrice());


        pizza = new BeefPizza();
        System.out.println(pizza + " $" + pizza.getPrice());

    }
}