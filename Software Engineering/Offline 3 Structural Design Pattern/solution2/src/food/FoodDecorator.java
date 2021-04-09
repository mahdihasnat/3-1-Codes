package src.food;

public abstract class FoodDecorator implements Food {
    private Food food;

    public FoodDecorator(Food food) {
        this.food = food;
    }

    @Override
    public int getPrice() {
        return food.getPrice();
    }

    @Override
    public String toString() {
        return food.toString() ;
    }
}
