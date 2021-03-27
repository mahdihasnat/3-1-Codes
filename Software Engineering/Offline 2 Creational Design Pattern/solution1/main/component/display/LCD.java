package main.component.display;

public class LCD implements Display {
    @Override
    public String toString() {
        return "LCD{}";
    }

    @Override
    public void print(String text) {
        System.out.println("print text using LCD");
    }
}
