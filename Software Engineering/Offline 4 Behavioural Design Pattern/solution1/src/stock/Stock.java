package stock;

import user.IUser;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class Stock implements IStock {
    private Vector<IUser> users;
    private String name;
    private int count;
    private float price;

    public Stock(String name, int count, float price) {
        this.name = name;
        this.count = count;
        this.price = price;
        this.users = new Vector<>();
    }

    @Override
    public void register(IUser user) {
        int index = this.users.indexOf(user);
        if (index != -1) {
            System.out.println(user + " already registered for stock " + this);
        } else {
            this.users.add(user);
            System.out.println(user + " registered for stock " + this);

        }
    }

    @Override
    public void unRegister(IUser user) {
        this.users.remove(user);
        System.out.println(user + " unregistered for stock " + this);
    }

    @Override
    public void notifyUsers() {
        System.out.println(getName() + " is notifying its observer");
        for (IUser user : users) {
            System.out.println("Notifying : " + user);
            user.update(this);
        }
    }

    @Override
    public int getCount() {
        return count;
    }

    @Override
    public float getPrice() {
        return price;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return "Stock{" +
                "users=" + users +
                ", name='" + name + '\'' +
                ", count=" + count +
                ", price=" + price +
                '}';
    }

    @Override
    public String getInformation() {
        return name + " " + count + " " + price;
    }

    @Override
    public void addPrice(float addAmount) {
        if (addAmount != 0) {
            price += addAmount;
            notifyUsers();
        } else {
            System.out.println("Price not changed");
        }
    }

    @Override
    public void setCount(int newCount) {
        if (count != newCount) {
            count = newCount;
            notifyUsers();
        } else {
            System.out.println("Count not changed");
        }
    }
}
