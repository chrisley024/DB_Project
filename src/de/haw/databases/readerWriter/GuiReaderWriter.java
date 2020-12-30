package de.haw.databases.readerWriter;

import javax.swing.JOptionPane;

/**
 * Simple gui reader and writer
 * 
 * @author Florian J. Ocker
 *
 */
public class GuiReaderWriter implements IReaderWriter {

  @Override
  public String read(String help) {
    return JOptionPane.showInputDialog(null, help);
  }

  @Override
  public void write(Object message) {
    JOptionPane.showMessageDialog(null, message);
  }

  @Override
  public void close() throws Exception {
    // nothing to do
  }

}
