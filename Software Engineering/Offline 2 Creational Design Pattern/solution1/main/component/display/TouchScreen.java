package main.component.display;

import main.component.controller.Controller;

public class TouchScreen implements Display  , Controller {
    @Override
    public String toString() {
        return "TouchScreen{}";
    }

    @Override
    public void print(String text) {
        System.out.println("print text using TouchScreen");
    }

    @Override
    public String getInput() {
        return "Input from touchScreen";
    }
}
