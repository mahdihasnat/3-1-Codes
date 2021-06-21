package user;

import stock.IStock;

public interface IUser {
    public void update(IStock stock);

    public void sendMessage(String message);
}
