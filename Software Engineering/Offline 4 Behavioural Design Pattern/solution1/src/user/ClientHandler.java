package user;

import stock.StockManager;

import java.io.*;
import java.net.Socket;

public class ClientHandler extends Thread {
    IUser user;
    Socket socket;


    public ClientHandler(IUser user, Socket socket) {
        super("ClientHandler Thread for user:" + user);
        this.user = user;
        this.socket = socket;
    }

    @Override
    public void run() {
        DataInputStream dis = null;
        try {
            dis = new DataInputStream(socket.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }

        while (true) {
            try {
                String line = dis.readUTF();
                System.out.println(user + " says :" + line);
                String[] data = line.strip().split(" ");
                if (data[0].equals("S")) {
                    StockManager.getInstance().register(data[1], user);
                } else if (data[0].equals("U")) {
                    StockManager.getInstance().unRegister(data[1], user);
                } else {
                    System.out.println("command not supported :" + data[0]);
                }
            } catch (IOException e) {
                e.printStackTrace();
                break;
            }

        }
    }
}
