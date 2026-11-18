package com.cloudpad.controller;
import java.net.*;
public class QcTest {
  static int fails=0;
  static void check(String n, boolean ok){ System.out.println((ok?"PASS ":"FAIL ")+n); if(!ok) fails++; }
  public static void main(String[] a) throws Exception {
    check("private 192.168 ok", QuickConnect.validTarget("192.168.137.1","47124"));
    check("private 10.x ok", QuickConnect.validTarget("10.253.57.1","47124"));
    check("private 172.16-31 ok", QuickConnect.validTarget("172.17.57.250","47124") && !QuickConnect.validTarget("172.32.0.1","47124"));
    check("public IP rejected", !QuickConnect.validTarget("8.8.8.8","47124") && !QuickConnect.validTarget("142.250.0.1","47124"));
    check("loopback/link-local rejected", !QuickConnect.validTarget("127.0.0.1","47124") && !QuickConnect.validTarget("169.254.1.1","47124"));
    check("bad ports rejected", !QuickConnect.validTarget("192.168.1.2","80") && !QuickConnect.validTarget("192.168.1.2","70000") && !QuickConnect.validTarget("192.168.1.2","abc") && !QuickConnect.validTarget("192.168.1.2",null));
    check("malformed ip rejected", !QuickConnect.validTarget("192.168.1","47124") && !QuickConnect.validTarget("192.168.1.256","47124") && !QuickConnect.validTarget("a.b.c.d","47124") && !QuickConnect.validTarget(null,"47124"));
    // sendHello with a fake UsbLink and a local UDP listener standing in for the laptop
    DatagramSocket laptop = new DatagramSocket(0, InetAddress.getByName("127.0.0.1")); laptop.setSoTimeout(3000);
    DatagramSocket phone = new DatagramSocket(0, InetAddress.getByName("127.0.0.1"));
    byte[] name = "CPN1Test phone".getBytes("UTF-8");
    new Thread(() -> { try { Thread.sleep(300); UsbLink.current = new UsbLink(name); UsbLink.current.socket = phone; } catch (Exception e) {} }).start();   // link comes up late
    boolean sent = QuickConnect.sendHello("127.0.0.1", laptop.getLocalPort());
    DatagramPacket p = new DatagramPacket(new byte[100], 100); laptop.receive(p);
    check("hello sent after waiting for the link", sent);
    check("laptop receives CPN1 + name", new String(p.getData(),0,p.getLength(),"UTF-8").equals("CPN1Test phone"));
    check("sent from the app's own socket", p.getPort()==phone.getLocalPort());
    System.exit(fails==0?0:1);
  }
}
