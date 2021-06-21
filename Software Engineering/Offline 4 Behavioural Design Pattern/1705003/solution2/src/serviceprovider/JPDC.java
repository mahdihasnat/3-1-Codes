package serviceprovider;

import citycorporation.CityCorporation;
import service.Service;
import service.ServiceType;

public class JPDC extends ServiceProvider {
    public JPDC(CityCorporation cityCorporation) {
        super(cityCorporation);
    }

    @Override
    public void serveService() {
        Service service = this.cityCorporation.getService(ServiceType.POWER);
        System.out.println("JPDC serving " + service);
    }

    @Override
    public String toString() {
        return "JPDC{" +
                "cityCorporation=" + cityCorporation +
                '}';
    }
}
