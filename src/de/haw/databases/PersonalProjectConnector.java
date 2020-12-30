package de.haw.databases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * This class provides any access to your database and has to be implemented by you.
 * 
 * @author <your name> //TODO
 *
 */
public class PersonalProjectConnector implements AutoCloseable {
  protected Connection connection;

  public PersonalProjectConnector(String url, String user, String password) throws SQLException {
    // TODO establish the connection
			System.out.println("Connecting to database: " + url);
			
			connection = DriverManager.getConnection(url, user, password);
						
			System.out.println("Connection successful!!!");		
  }

  @Override
  public void close() throws SQLException {
    // TODO: close the connection
	  connection.close();
  }

  /**
   * TODO rename method to name what it provides <br>
   * TODO change params and return type <br>
   * TODO implement missing parts
   * TODO delete placeholder answers
   */
  
  // product info less than a given price
  public List<String> priceCheck(Integer sellPrice, String productName) throws SQLException {
	 List<String> result = new ArrayList<String>();
    String sql = "SELECT product.name, sells.product_url, retailer.name, sells.price"
    		+ " FROM sells"
    		+ " JOIN product ON product.id = sells.product_id"
    		+ " JOIN retailer ON retailer.id = sells.retailer_id"
    		+ " WHERE sells.price <= ? AND product.name = ?";

    PreparedStatement statement = connection.prepareStatement(sql); // use connection to create
    // add condition parameters (here: universityId) to statement
    statement.setInt(1, sellPrice);
    statement.setString(2, productName);
    
    ResultSet resultSet = statement.executeQuery(); // by executing the statement as a query
    System.out.println( productName + " with price <= " + sellPrice + " and products info");

    while(resultSet.next()) {
    	result.add(resultSet.getString("product.name"));
    	result.add(resultSet.getString("sells.product_url"));
    	result.add(resultSet.getString("retailer.name"));
    	result.add(resultSet.getString("sells.price"));

    }
 
	return result;
  }

}
