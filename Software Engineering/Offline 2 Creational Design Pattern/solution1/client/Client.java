package client;

import main.component.internet.Internet;
import main.machine.Machine;
import main.machinebuilder.MachineBuilder;

import java.util.Scanner;

public class Client {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        MachineBuilder machineBuilder = new MachineBuilder();
        String packageType,connectionType,serverType;

        System.out.println("Type one of these package:[Silver,Gold,Diamond,Platinum]");
        packageType = sc.next();

        System.out.println("Type one of internet connection method:[Wifi,Gsm,Ethernet]");
        connectionType = sc.next();

        Internet connection =MachineBuilder.getInternetFromConnectionType(connectionType);

        if(packageType.equalsIgnoreCase("Silver"))
            machineBuilder.addSilverPackage(connection);
        else if(packageType.equalsIgnoreCase("gold"))
            machineBuilder.addGoldPackage(connection);
        else if(packageType.equalsIgnoreCase("diamond"))
            machineBuilder.addDiamondPackage(connection);
        else if(packageType.equalsIgnoreCase("platinum"))
            machineBuilder.addPlatinumPackage(connection);
        else {
            System.out.println("Invalid Package name:"+packageType);
            return;
        }
        System.out.println("Choose Framework for Web Server:[Django, Spring and Laravel]");

        serverType = sc.next();

        machineBuilder.addServer(serverType);

        Machine machine  = machineBuilder.getMachine();

        System.out.println(machine);

    }
}