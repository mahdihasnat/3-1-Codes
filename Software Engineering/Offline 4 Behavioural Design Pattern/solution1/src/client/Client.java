package client;

import javax.imageio.plugins.tiff.ExifTIFFTagSet;
import java.io.*;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Scanner;

public class Client {
    public static void main(String[] args) {
        try (Socket socket = new Socket("localhost", 1245)) {
            System.out.println("Server found");

            ClientReader clientReader = new ClientReader(socket);
            clientReader.start();

            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
            DataOutputStream dos = new DataOutputStream(socket.getOutputStream());

            while (true) {
                String line = null;
                line = reader.readLine();
                String[] com = line.strip().split(" ");
                if (com.length == 2 && (com[0].equals("S") || com[0].equals("U"))) {
                    dos.writeUTF(com[0] + " " + com[1]);
                    dos.flush();
                } else if (line.equals("exit")) {
                    System.exit(0);
                } else {
                    System.out.println("command not supported :" + line);
                }

            }

        } catch (UnknownHostException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
