package client;

import java.io.*;
import java.net.Socket;

public class ClientReader extends Thread {
    Socket socket;

    public ClientReader(Socket socket) {
        super("Client Console");
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
        String line = null;
        while (true) {
            try {
                line = dis.readUTF();
            } catch (IOException e) {
                e.printStackTrace();
                break;
            }
            if (line == null)
                break;
            System.out.println(line);
        }
    }
}
