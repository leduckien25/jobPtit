
package model;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class Job {
    private int id;
    private String title;
    private String description;
    private String location;
    
    private Integer salaryMin; 
    private Integer salaryMax;
    private boolean isNegotiable;
    
    private int jobType; // 1=FullTime, 2=PartTime, 3=Internship
    private int status;  // 0=Pending, 1=Active, 2=Expired, 3=Rejected
    
    private int categoryId;
    private int companyId;
    private int createdByUserId;
    
    private int viewsCount;
    private LocalDateTime createdAt;
    private  LocalDateTime expiredAt;

    private String companyName;
    private String companyLogo;
    private Company company;
    private int applicationsCount;

    public int getApplicationsCount() {
        return applicationsCount;
    }

    public void setApplicationsCount(int applicationsCount) {
        this.applicationsCount = applicationsCount;
    }
    
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private static final NumberFormat CURRENCY_FORMATTER = NumberFormat.getInstance(new Locale("vi", "VN"));
    public Job(String title, String location, String description, int salaryMax, int salaryMin, int jobType, int status, int categoryId, boolean negotiable, LocalDateTime deadline) {
        this.title = title;
        this.location = location;
        this.description = description;
        this.salaryMax = salaryMax;
        this.salaryMin = salaryMin;
        this.jobType = jobType;
        this.status = status;
        this.categoryId = categoryId;
        this.isNegotiable = negotiable;
        this.expiredAt = deadline;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public Job() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Integer getSalaryMin() {
        return salaryMin;
    }

    public void setSalaryMin(Integer salaryMin) {
        this.salaryMin = salaryMin;
    }

    public Integer getSalaryMax() {
        return salaryMax;
    }

    public void setSalaryMax(Integer salaryMax) {
        this.salaryMax = salaryMax;
    }

    public boolean getIsNegotiable() {
        return isNegotiable;
    }

    public void setIsNegotiable(boolean isNegotiable) {
        this.isNegotiable = isNegotiable;
    }

    public int getJobType() {
        return jobType;
    }

    public void setJobType(int jobType) {
        this.jobType = jobType;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public int getCreatedByUserId() {
        return createdByUserId;
    }

    public void setCreatedByUserId(int createdByUserId) {
        this.createdByUserId = createdByUserId;
    }

    public int getViewsCount() {
        return viewsCount;
    }

    public void setViewsCount(int viewsCount) {
        this.viewsCount = viewsCount;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getExpiredAt() {
        return expiredAt;
    }
    public String getSalaryRangeFormatted() {
        if (this.isNegotiable) {
            return "Thỏa thuận";
        }
        
        double min = (double) salaryMin / 1000000;
        double max = (double) salaryMax / 1000000;
        
        if (min == max) {
            return String.format("%.0f triệu", min);
        }
        return String.format("%.0f - %.0f triệu", min, max);
    }
    public String getCreatedAtFormatted() {
        return (createdAt != null) ? createdAt.format(DATE_FORMATTER) : "N/A";
    }
    public String getDeadlineFormatted() {
        return (expiredAt != null) ? expiredAt.toLocalDate().format(DATE_FORMATTER) : "N/A";
    }
    public String getExpiredAtDateOnly() {
        if (this.expiredAt == null) return "";
        return this.expiredAt.toLocalDate().toString(); 
    }
    public void setExpiredAt(LocalDateTime expiredAt) {
        this.expiredAt = expiredAt;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyLogo() {
        return companyLogo;
    }

    public void setCompanyLogo(String companyLogo) {
        this.companyLogo = companyLogo;
    }
    
    
}
