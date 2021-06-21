package citycorporation;

import service.Service;
import service.ServiceType;
import serviceprovider.ServiceProvider;

public interface CityCorporation {
    void addServiceRequest(ServiceType serviceType, Service service);

    Service getService(ServiceType serviceType);
}
