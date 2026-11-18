package com.cloudpad.controller;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.widget.Toast;

import java.lang.reflect.Field;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

/**
 * Joins a laptop from a scanned QR code. The QR opens cloudpad://connect?ip=...&port=...; we then send our
 * name ("CPN1" + name) to that laptop address from the app's normal network socket, and the Bridge answers with
 * its usual hello, so everything after that is the same link used for USB and Wi-Fi.
 */
public final class QuickConnect {
    private QuickConnect() {}

    /** Called from MainActivity.onCreate and onNewIntent. Handles each scanned link once. */
    public static void handle(final Activity a, Intent intent) {
        if (a == null || intent == null) return;
        Uri u = intent.getData();
        if (u == null || !"cloudpad".equals(u.getScheme()) || !"connect".equals(u.getHost())) return;
        intent.setData(null);
        final String ip = u.getQueryParameter("ip");
        final String portText = u.getQueryParameter("port");
        if (!validTarget(ip, portText)) {
            Toast.makeText(a, "That QR code isn't for CloudPad on your network", Toast.LENGTH_LONG).show();
            return;
        }
        final int port = Integer.parseInt(portText);
        Toast.makeText(a, "Connecting to your laptop...", Toast.LENGTH_SHORT).show();
        new Thread(new Runnable() {
            @Override
            public void run() {
                sendHello(ip, port);
            }
        }, "CloudPad-QR").start();
    }

    /** Only private-network IPv4 addresses and unprivileged ports: a QR code must not point the phone at the internet. */
    static boolean validTarget(String ip, String portText) {
        if (ip == null || portText == null) return false;
        String[] p = ip.split("\\.", -1);
        if (p.length != 4) return false;
        int[] o = new int[4];
        try {
            for (int i = 0; i < 4; i++) {
                if (p[i].length() == 0 || p[i].length() > 3) return false;
                o[i] = Integer.parseInt(p[i]);
                if (o[i] < 0 || o[i] > 255) return false;
            }
            int port = Integer.parseInt(portText);
            if (port < 1024 || port > 65535) return false;
        } catch (NumberFormatException e) {
            return false;
        }
        boolean priv = o[0] == 10 || (o[0] == 172 && o[1] >= 16 && o[1] <= 31) || (o[0] == 192 && o[1] == 168);
        return priv;
    }

    /** Sends our name to the laptop a few times (UDP can drop packets). Waits briefly for the link to be ready. */
    static boolean sendHello(String ip, int port) {
        try {
            Class<?> c = Class.forName("com.cloudpad.controller.UsbLink");
            Field cur = c.getDeclaredField("current");
            Field sock = c.getDeclaredField("socket");
            Field name = c.getDeclaredField("nameBytes");
            cur.setAccessible(true);
            sock.setAccessible(true);
            name.setAccessible(true);
            InetAddress to = InetAddress.getByName(ip);
            DatagramSocket s = null;
            byte[] hello = null;
            for (int i = 0; i < 40 && (s == null || hello == null); i++) {      // up to ~4 s for the app's socket
                Object link = cur.get(null);
                if (link != null) {
                    s = (DatagramSocket) sock.get(link);
                    hello = (byte[]) name.get(link);
                }
                if (s == null || hello == null) Thread.sleep(100);
            }
            if (s == null || hello == null) return false;
            for (int i = 0; i < 6; i++) {
                s.send(new DatagramPacket(hello, hello.length, to, port));
                Thread.sleep(250);
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
