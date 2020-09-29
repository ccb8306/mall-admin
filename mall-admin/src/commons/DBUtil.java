package commons;
import java.sql.*;

public class DBUtil {
	
	public Connection getConnection()throws Exception{	
		String driver = "org.mariadb.jdbc.Driver";
		String dbid = "root";
		String dbpw = "java1004";
		String dbaddr = "jdbc:mariadb://localhost:3306/mall";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(dbaddr,dbid,dbpw);	
		return conn;
	}
	
}
