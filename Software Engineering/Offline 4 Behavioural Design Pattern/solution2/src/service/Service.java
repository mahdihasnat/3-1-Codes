package service;

import serviceprovider.ServiceProvider;

public class Service {
    ServiceProvider location;

    public Service(ServiceProvider location) {
        this.location = location;
    }

    @Override
    public String toString() {
        return "Service{" +
                "location=" + location +
                '}';
    }
}
