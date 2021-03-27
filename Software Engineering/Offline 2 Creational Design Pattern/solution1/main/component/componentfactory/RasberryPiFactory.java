package main.component.componentfactory;

import main.component.controller.Controller;
import main.component.display.Display;
import main.component.display.TouchScreen;
import main.component.identification.Identification;
import main.component.identification.NFC;
import main.component.internet.Internet;
import main.component.processor.Processor;
import main.component.processor.RasberryPi;
import main.component.storage.Storage;

public class RasberryPiFactory implements ComponentFactory {
    RasberryPi rasberryPi;
    TouchScreen touchScreen;
    @Override
    public Processor getProcessor() {
        if(rasberryPi == null)
            rasberryPi = new RasberryPi();
        return rasberryPi;
    }

    @Override
    public Identification getIdentification() {
        return new NFC();
    }

    @Override
    public Storage getStorage() {
        if(rasberryPi == null)
            rasberryPi = new RasberryPi();
        return rasberryPi;
    }

    @Override
    public Display getDisplay() {
        if(touchScreen == null)
            touchScreen = new TouchScreen();
        return touchScreen;
    }

    @Override
    public Internet getInternet(Internet connection) {
        return connection;
    }

    @Override
    public Controller getController() {
        if(touchScreen == null)
            touchScreen = new TouchScreen();
        return touchScreen;
    }
}
