package main.component.display;

public class LED implements Display {
    @Override
    public String toString() {
        return "LED{}";
    }

    @Override
    public void print(String text) {
        System.out.println("print text using LED");
    }
}
