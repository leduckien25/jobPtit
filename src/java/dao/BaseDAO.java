package dao;

import java.sql.Connection;
import config.DBConnection;

public class BaseDAO {
    protected Connection conn;

    public BaseDAO() {
        conn = DBConnection.getConnection();
    }
}