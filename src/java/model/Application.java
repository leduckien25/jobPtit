package model;

import java.sql.Timestamp;

public class Application {
    private int id;
    private int userId;
    private int jobId;
    private int status;
    private Timestamp appliedAt;
    
    // Hai trường này cực kỳ quan trọng để hiển thị Tên Công Việc và Công Ty lên Figma
    private String jobTitle;
    private String companyName;

    public Application() {}

    // Các hàm Getter/Setter (Đảm bảo tên phải y hệt như này)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public Timestamp getAppliedAt() { return appliedAt; }
    public void setAppliedAt(Timestamp appliedAt) { this.appliedAt = appliedAt; }

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
}