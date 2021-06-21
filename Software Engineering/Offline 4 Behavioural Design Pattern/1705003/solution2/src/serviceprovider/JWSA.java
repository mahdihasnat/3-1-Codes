package serviceprovider;

import citycorporation.CityCorporation;
import service.Service;
import service.ServiceType;

public class JWSA extends ServiceProvider {
    public JWSA(CityCorporation cityCorporation) {
        super(cityCorporation);
    }

    @Override
    public void serveService() {
        Service service = this.cityCorporation.getService(ServiceType.WATER);
        System.out.println("JWSA is serving " + service);
    }


    @Override
    public String toString() {
        return "JWSA{" +
                "cityCorporation=" + cityCorporation +
                '}';
    }
}
