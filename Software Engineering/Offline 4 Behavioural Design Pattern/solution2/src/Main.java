import citycorporation.CityCorporation;
import citycorporation.JCC;
import service.ServiceType;
import serviceprovider.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {

    public static void main(String[] args) {
        CityCorporation cityCorporation = null;
        ServiceProvider jwsa = null;
        ServiceProvider jpdc = null;
        ServiceProvider jrta = null;
        ServiceProvider jtrc = null;

        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        while (true) {
            String line = null;
            try {
                line = br.readLine();
//                System.out.println(line);

                if (line.equalsIgnoreCase("exit"))
                    System.exit(0);

                else if (line.equalsIgnoreCase("init")) {
                    cityCorporation = new JCC();
                    jwsa = new JWSA(cityCorporation);
                    jpdc = new JPDC(cityCorporation);
                    jrta = new JRTA(cityCorporation);
                    jtrc = new JTRC(cityCorporation);

                    System.out.println(cityCorporation);
                    System.out.println(jwsa);
                    System.out.println(jpdc);
                    System.out.println(jrta);
                    System.out.println(jtrc);
                } else {
                    String[] commands = line.strip().split(" ");
                    if (commands.length != 2) {
                        System.out.println("invalid command :" + line);
                    } else {
                        String company = commands[0];
                        String operation = commands[1];

                        ServiceProvider com = null;
                        if (company.equalsIgnoreCase("jwsa")) com = jwsa;
                        else if (company.equalsIgnoreCase("jpdc")) com = jpdc;
                        else if (company.equalsIgnoreCase("jrta")) com = jrta;
                        else if (company.equalsIgnoreCase("jtrc")) com = jtrc;
                        else {
                            System.out.println("Unknown company :" + company);
                            continue;
                        }

                        if (operation.equalsIgnoreCase("POWER")) com.requestService(ServiceType.POWER);
                        else if (operation.equalsIgnoreCase("TELECOM")) com.requestService(ServiceType.TELECOM);
                        else if (operation.equalsIgnoreCase("WATER")) com.requestService(ServiceType.WATER);
                        else if (operation.equalsIgnoreCase("TRANSPORT")) com.requestService(ServiceType.TRANSPORT);
                        else if (operation.equalsIgnoreCase("SERVE")) com.serveService();
                        else {
                            System.out.println("Unknown operation :" + operation);
                            continue;
                        }
                    }
                }

            } catch (IOException e) {
                e.printStackTrace();
            }

        }

    }
}
