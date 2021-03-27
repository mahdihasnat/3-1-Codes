package main.component.componentfactory;

import main.component.controller.Button;
import main.component.controller.Controller;
import main.component.display.Display;
import main.component.display.LCD;
import main.component.identification.Identification;
import main.component.identification.RFID;
import main.component.internet.Internet;
import main.component.internet.WireLess;
import main.component.processor.ATMega32;
import main.component.processor.Processor;
import main.component.storage.SDCard;
import main.component.storage.Storage;

public class ATMega32Factory implements ComponentFactory {
    @Override
    public Processor getProcessor() {
        return new ATMega32();
    }

    @Override
    public Identification getIdentification() {
        return new RFID();
    }

    @Override
    public Storage getStorage() {
        return new SDCard();
    }

    @Override
    public Display getDisplay() {
        return new LCD();
    }

    @Override
    public Internet getInternet(Internet connection) {
        if (connection instanceof WireLess)
            return connection;
        else return null;
    }

    @Override
    public Controller getController() {
        return new Button();
    }
}
