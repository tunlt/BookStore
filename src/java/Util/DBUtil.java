/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Util;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Tu
 */
public class DBUtil {
    
  public static Connection getConnection()
    throws NamingException, SQLException{
        
        Context currentContext = new InitialContext();// get OS Naming and Directory
        Context tomcatContext = (Context)currentContext.lookup("java:comp/env"); // neu dung driver khac thi nen doc patch cuar server do
        DataSource ds = (DataSource)tomcatContext.lookup("DS02");
        Connection con = ds.getConnection();
        
        return con;
   }
   
}
