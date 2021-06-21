package serviceprovider;

import citycorporation.CityCorporation;
import service.Service;
import service.ServiceType;

public class JRTA extends ServiceProvider {
    public JRTA(CityCorporation cityCorporation) {
        super(cityCorporation);
    }

    @Override
    public void serveService() {
        Service service = this.cityCorporation.getService(ServiceType.TRANSPORT);
        System.out.println("JRTA is serving " + service);
    }

    @Override
    public String toString() {
        return "JRTA{" +
                "cityCorporation=" + cityCorporation +
                '}';
    }
}
