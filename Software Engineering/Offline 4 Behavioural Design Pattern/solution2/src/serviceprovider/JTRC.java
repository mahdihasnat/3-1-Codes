package serviceprovider;

import citycorporation.CityCorporation;
import service.Service;
import service.ServiceType;

public class JTRC extends ServiceProvider {
    public JTRC(CityCorporation cityCorporation) {
        super(cityCorporation);
    }

    @Override
    public void serveService() {
        Service service = this.cityCorporation.getService(ServiceType.TELECOM);
        System.out.println("JTRC is serving " + service);
    }

    @Override
    public String toString() {
        return "JTRC{" +
                "cityCorporation=" + cityCorporation +
                '}';
    }
}
