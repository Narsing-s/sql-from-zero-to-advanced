import java.sql.*;

public class ClientExample {
  public static void main(String[] args) throws Exception {
    try (Connection c = DriverManager.getConnection(System.getenv("DATABASE_URL"))) {
      c.setAutoCommit(false);
      try (PreparedStatement p = c.prepareStatement("SELECT ?::integer AS id")) {
        p.setInt(1, 1);
        try (ResultSet rs = p.executeQuery()) {
          while (rs.next()) System.out.println(rs.getInt("id"));
        }
      }
      c.commit();
    }
  }
}
