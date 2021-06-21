package user;

import stock.IStock;

public class User implements IUser {
    private String name;
    private ClientNotifier clientNotifier;

    public User(String name, ClientNotifier clientNotifier) {
        this.name = name;
        this.clientNotifier = clientNotifier;
    }

    @Override
    public void update(IStock stock) {
        String msg = "Stock changed to :" + stock.getInformation();
        this.clientNotifier.setMessage(msg);
    }

    @Override
    public void sendMessage(String message) {
        this.clientNotifier.setMessage(message);
    }

    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                '}';
    }
}
