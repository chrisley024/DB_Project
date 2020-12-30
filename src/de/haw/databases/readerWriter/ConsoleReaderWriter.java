package de.haw.databases.readerWriter;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Simple console reader and writer
 * 
 * @author Florian J. Ocker
 *
 */
public class ConsoleReaderWriter implements IReaderWriter {

  private BufferedReader reader;

  public ConsoleReaderWriter() {
    reader = new BufferedReader(new InputStreamReader(System.in));
  }

  @Override
  public String read(String help) {
    write(help);
    try {
      return reader.readLine();
    } catch (IOException e) {
      return null;
    }
  }

  @Override
  public void write(Object message) {
    System.out.println(message);
  }

  @Override
  public void close() throws Exception {
    reader.close();
  }

}
