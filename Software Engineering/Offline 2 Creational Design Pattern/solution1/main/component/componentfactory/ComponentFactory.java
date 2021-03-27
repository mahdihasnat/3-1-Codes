package main.component.componentfactory;

import main.component.controller.Controller;
import main.component.display.Display;
import main.component.identification.Identification;
import main.component.internet.Internet;
import main.component.processor.Processor;
import main.component.storage.Storage;

public interface ComponentFactory {
    Processor getProcessor();
    Identification getIdentification();
    Storage getStorage();
    Display getDisplay();
    Internet getInternet(Internet connection);
    Controller getController();
}
