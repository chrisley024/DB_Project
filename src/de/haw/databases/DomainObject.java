package de.haw.databases;

/**
 * Example data object. 
 * TODO Rename to an entity of your domain.
 * TODO Change variables to fit that domain object of your database.
 *
 */
public class DomainObject {
  private Integer id;
  private String name;

  public DomainObject(Integer id, String name) {
    this.id = id;
    this.name = name;
  }

  public Integer getId() {
    return id;
  }

  public String getName() {
    return name;
  }
}