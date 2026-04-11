package dao;

import java.sql.Connection;
import data.DBUtils;
import java.sql.SQLException;

public class BaseDAO {
    protected Connection conn;

    public BaseDAO() throws SQLException {
        conn = DBUtils.getConnection();
    }
}