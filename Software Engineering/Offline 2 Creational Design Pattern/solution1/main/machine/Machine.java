package main.machine;

import main.component.controller.Controller;
import main.component.display.Display;
import main.component.identification.Identification;
import main.component.internet.Internet;
import main.component.processor.Processor;
import main.server.Server;
import main.component.storage.Storage;
import main.component.weightmeasurement.WeightMeasurement;

public class Machine {
    private Processor processor;
    private WeightMeasurement weightMeasurement;
    private Identification identification;
    private Storage storage;
    private Display display;
    private Internet internet;
    private Controller controller;

    private Server server;

    public Machine() {
    }

    @Override
    public String toString() {
        return "Machine{" +
                "processor=" + processor +
                ", weightMeasurement=" + weightMeasurement +
                ", identification=" + identification +
                ", storage=" + storage +
                ", display=" + display +
                ", internet=" + internet +
                ", controller=" + controller +
                ", server=" + server +
                '}';
    }

    public Processor getProcessor() {
        return processor;
    }

    public void setProcessor(Processor processor) {
        this.processor = processor;
    }

    public WeightMeasurement getWeightMeasurement() {
        return weightMeasurement;
    }

    public void setWeightMeasurement(WeightMeasurement weightMeasurement) {
        this.weightMeasurement = weightMeasurement;
    }

    public Identification getIdentification() {
        return identification;
    }

    public void setIdentification(Identification identification) {
        this.identification = identification;
    }

    public Storage getStorage() {
        return storage;
    }

    public void setStorage(Storage storage) {
        this.storage = storage;
    }

    public Display getDisplay() {
        return display;
    }

    public void setDisplay(Display display) {
        this.display = display;
    }

    public Internet getInternet() {
        return internet;
    }

    public void setInternet(Internet internet) {
        this.internet = internet;
    }

    public Controller getController() {
        return controller;
    }

    public void setController(Controller controller) {
        this.controller = controller;
    }

    public Server getServer() {
        return server;
    }

    public void setServer(Server server) {
        this.server = server;
    }
}
