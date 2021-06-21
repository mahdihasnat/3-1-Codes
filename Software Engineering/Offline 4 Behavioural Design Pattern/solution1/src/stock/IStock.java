package stock;

import user.IUser;

public interface IStock {
    public void register(IUser user);

    public void unRegister(IUser user);

    public void notifyUsers();

    public int getCount();

    public float getPrice();

    public String getName();

    public String getInformation();

    public void addPrice(float addAmount);

    public void setCount(int newCount);
}
