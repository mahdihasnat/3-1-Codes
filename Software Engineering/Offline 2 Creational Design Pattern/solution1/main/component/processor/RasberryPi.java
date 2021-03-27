package main.component.processor;

import main.component.storage.Storage;

public class RasberryPi implements Processor , Storage {
    @Override
    public String toString() {
        return "RasberryPi{}";
    }
}
