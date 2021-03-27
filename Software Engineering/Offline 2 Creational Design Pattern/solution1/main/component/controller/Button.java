package main.component.controller;

public class Button implements Controller {
    @Override
    public String toString() {
        return "Button{}";
    }

    @Override
    public String getInput() {
        return "input Using Button";
    }
}
