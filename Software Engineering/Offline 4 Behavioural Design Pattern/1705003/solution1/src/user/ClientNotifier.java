package user;

import stock.StockManager;

import java.io.*;
import java.net.Socket;

public class ClientNotifier extends Thread {
    Socket socket;
    private String message;

    public ClientNotifier(String clientName, Socket socket) {
        super("ClientNotifier Thread of " + clientName);
        this.socket = socket;
        this.message = null;
    }

    synchronized public void run() {
        DataOutputStream dos = null;
        try {
            dos = new DataOutputStream(socket.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        String stocks = StockManager.getInstance().getMarketInformation();

        try {
            dos.writeUTF(stocks);
            dos.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }

        while (true) {
            while (this.message == null) {
                notifyAll();
                try {
                    wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            try {
                dos.writeUTF(this.message);
                dos.flush();

            } catch (IOException e) {
                e.printStackTrace();
            }
            this.message = null;
            notifyAll();
        }
    }

    synchronized public String getMessage() {
        return message;
    }

    synchronized public void setMessage(String message) {

        while (this.message != null) {
            System.out.println("msg in queue :" + message);
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        this.message = message;
        notifyAll();
    }
}
