import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DbConnection {

    private Connection conn;
    private static final String teacherTable = "teacher";

    public DbConnection() throws SQLException, ClassNotFoundException {

        //connecting to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("Connecting to the CLASSES - Database...");
        conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/tests" +
                        "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
                "root",
                "");
    }
    //kills connection
    public void closeDb() throws SQLException {
        conn.close();
    }

    //selects all the teachers from the database
    public List<Teacher> teacherList()  throws SQLException {

        String sql = "SELECT * FROM " + teacherTable;
        PreparedStatement pstmnt = conn.prepareStatement(sql);
        ResultSet rs = pstmnt.executeQuery();
        List<Teacher> list = new ArrayList<>();

        while (rs.next()) {
            int id = rs.getInt("teacher_id");
            String name = rs.getString("teacher_name");
            String surname = rs.getString("teacher_surname");
            String email = rs.getString("teacher_emal");
            list.add(new Teacher(id, name, surname, email));
        }
        pstmnt.close();
        return list;
    }

    //selects the classnames with filter depending on teachers id
    public List<Classes> classList(int i) throws SQLException {
        String sql = "SELECT class.class_id, class.className FROM class INNER JOIN teaching ON class.class_id = teaching.fk_class_id WHERE teaching.fk_teacher_id = ?";
        PreparedStatement pstmnt = conn.prepareStatement(sql);
        pstmnt.setInt(1, i);
        ResultSet rs = pstmnt.executeQuery();
        List<Classes> listClasses = new ArrayList<>();

        while (rs.next()) {
            int id = rs.getInt("class_id");
            String name = rs.getString("className");
            listClasses.add(new Classes(id, name));
        }
        pstmnt.close();
        return listClasses;
    }
}
