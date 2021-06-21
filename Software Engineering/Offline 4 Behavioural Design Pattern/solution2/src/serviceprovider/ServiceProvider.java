package serviceprovider;

import citycorporation.CityCorporation;
import service.Service;
import service.ServiceType;

public abstract class ServiceProvider {
    protected CityCorporation cityCorporation;

    public ServiceProvider(CityCorporation cityCorporation) {
        this.cityCorporation = cityCorporation;
    }

    public void requestService(ServiceType serviceType) {
        Service serviceNeeded = new Service(this);
        this.cityCorporation.addServiceRequest(serviceType, serviceNeeded);

    }

    public abstract void serveService();
}
