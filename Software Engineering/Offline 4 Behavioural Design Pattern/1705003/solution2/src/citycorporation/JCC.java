package citycorporation;

import service.Service;
import service.ServiceType;
import serviceprovider.ServiceProvider;

import java.util.EnumMap;
import java.util.LinkedList;
import java.util.Queue;

public class JCC implements CityCorporation {

    EnumMap<ServiceType, Queue<Service>> pendingServices;// this enum map is backed by arraylist implementation


    public JCC() {
        this.pendingServices = new EnumMap<>(ServiceType.class);
    }

    @Override
    public void addServiceRequest(ServiceType serviceType, Service service) {
        Queue<Service> pendingQueue = pendingServices.get(serviceType);
        if (pendingQueue == null) {
            pendingQueue = new LinkedList<Service>();
            pendingServices.put(serviceType, pendingQueue);
        }
        pendingQueue.add(service);
        System.out.println("Added service Request of " + serviceType + " : " + service);
    }

    @Override
    public Service getService(ServiceType serviceType) {
        Queue<Service> pendingQueue = pendingServices.get(serviceType);
        return pendingQueue.poll();
    }

    @Override
    public String toString() {
        return "JCC{}";
    }
}
