package de.haw.databases.readerWriter;

/**
 * Interface for reading and writing
 * 
 * @author Florian J. Ocker
 *
 */
public interface IReaderWriter extends AutoCloseable {

  /**
   * Reads a user input
   * 
   * @param help
   *          that is printed for the user to help with input
   * @return the input of the user
   */
  String read(String help);

  /**
   * Provides a message for the user
   * 
   * @param message
   *          that is printed for the user
   */
  void write(Object message);


}
