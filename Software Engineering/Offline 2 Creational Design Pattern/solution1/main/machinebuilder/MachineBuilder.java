package main.machinebuilder;

import main.component.componentfactory.ATMega32Factory;
import main.component.componentfactory.ArduinoMegaFactory;
import main.component.componentfactory.ComponentFactory;
import main.component.componentfactory.RasberryPiFactory;
import main.component.internet.Ethernet;
import main.component.internet.Gsm;
import main.component.internet.Internet;
import main.component.internet.Wifi;
import main.machine.Machine;
import main.server.Django;
import main.server.Laravel;
import main.server.Server;
import main.server.Spring;
import main.component.weightmeasurement.LoadSensor;
import main.component.weightmeasurement.WeightModule;

public class MachineBuilder {
    Machine machine;

    public MachineBuilder() {
        this.machine = new Machine();
    }

    private void addComponent(ComponentFactory componentFactory , Internet connection)
    {
        machine.setProcessor(componentFactory.getProcessor());
        machine.setIdentification(componentFactory.getIdentification());
        machine.setStorage(componentFactory.getStorage());
        machine.setDisplay(componentFactory.getDisplay());
        machine.setInternet(componentFactory.getInternet(connection));
        machine.setController(componentFactory.getController());
        if(machine.getInternet() == null)
            System.out.println(machine.getProcessor()+" does not support "+connection);
    }
    public static Internet getInternetFromConnectionType(String connectionType)
    {
        if(connectionType.equalsIgnoreCase("wifi"))
            return new Wifi();
        else if(connectionType.equalsIgnoreCase("gsm"))
            return new Gsm();
        else if(connectionType.equalsIgnoreCase("ethernet"))
            return new Ethernet();
        else {
            System.out.println("Invalid Internet Connection Type :"+connectionType);
            return null;
        }
    }
    public void addSilverPackage(Internet connection)
    {
        ComponentFactory componentFactory = new ATMega32Factory();
        addComponent(componentFactory , connection);
        machine.setWeightMeasurement(new LoadSensor());
    }

    public void addGoldPackage(Internet connection)
    {
        ComponentFactory componentFactory = new ArduinoMegaFactory();
        addComponent(componentFactory , connection);
        machine.setWeightMeasurement(new WeightModule());
    }

    public void addDiamondPackage(Internet connection)
    {
        ComponentFactory componentFactory = new RasberryPiFactory();
        addComponent(componentFactory , connection);
        machine.setWeightMeasurement(new LoadSensor());
    }

    public void addPlatinumPackage(Internet connection)
    {
        ComponentFactory componentFactory = new RasberryPiFactory();
        addComponent(componentFactory , connection);
        machine.setWeightMeasurement(new WeightModule());
    }

    public void addServer(String serverType)
    {
        Server server = null;
        if(serverType.equalsIgnoreCase("django"))
            server =new Django();
        else if(serverType.equalsIgnoreCase("spring"))
            server = new Spring();
        else if(serverType.equalsIgnoreCase("laravel"))
            server = new Laravel();
        else
        {
            System.out.println("No Server Matched with " + serverType);
        }
        machine.setServer(server);
    }

    public Machine getMachine()
    {
        return machine;
    }
}
