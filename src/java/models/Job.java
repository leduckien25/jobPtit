package models;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.text.NumberFormat;
import java.util.Locale;

public class Job {
    private int id;
    private String title;
    private String location;
    private String description;
    private int salaryMax;
    private int salaryMin;
    private int jobType;
    private int status;
    private int categoryId;
    private int negotiable;
    private int companyId;

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public int getCompanyId() {
        return companyId;
    }
    private LocalDate deadline;
    private LocalDate createdAt;

    // Các hằng số định dạng
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private static final NumberFormat CURRENCY_FORMATTER = NumberFormat.getInstance(new Locale("vi", "VN"));

    // --- PHƯƠNG THỨC BỔ SUNG ĐỂ HIỂN THỊ GIAO DIỆN (FORMATTED GETTERS) ---

    /**
     * Trả về khoảng lương định dạng: "5 - 10 triệu" hoặc "Thỏa thuận"
     */
    public String getSalaryRangeFormatted() {
        if (this.negotiable == 1) {
            return "Thỏa thuận";
        }
        
        // Giả sử lương lưu trong DB là đơn vị VNĐ (ví dụ: 10000000)
        // Chuyển sang đơn vị triệu để hiển thị gọn
        double min = (double) salaryMin / 1000000;
        double max = (double) salaryMax / 1000000;
        
        if (min == max) {
            return String.format("%.0f triệu", min);
        }
        return String.format("%.0f - %.0f triệu", min, max);
    }

    /**
     * Trả về ngày tạo định dạng dd/MM/yyyy
     */
    public String getCreatedAtFormatted() {
        return (createdAt != null) ? createdAt.format(DATE_FORMATTER) : "N/A";
    }

    /**
     * Trả về hạn nộp định dạng dd/MM/yyyy
     */
    public String getDeadlineFormatted() {
        return (deadline != null) ? deadline.format(DATE_FORMATTER) : "N/A";
    }

    // --- GETTERS & SETTERS CŨ ---

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    public Date getCreatedAt() {
        return (this.createdAt != null) ? Date.valueOf(this.createdAt) : null;
    }

    public void setDeadline(LocalDate deadline) {
        this.deadline = deadline;
    }

    public LocalDate getDeadline() {
        return this.deadline;
    }

    public void setJobType(int jobType) {
        this.jobType = jobType;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getJobType() {
        return this.jobType;
    }

    public int getStatus() {
        return this.status;
    }

    public int getCategoryId() {
        return this.categoryId;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getNegotiable() {
        return this.negotiable;
    }

    public void setNegotiable(int negotiable) {
        this.negotiable = negotiable;
    }

    public String getDescription() {
        return this.description;
    }

    public Job() {
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setSalaryMin(int salaryMin) {
        this.salaryMin = salaryMin;
    }

    public void setSalaryMax(int salaryMax) {
        this.salaryMax = salaryMax;
    }

    public int getId() {
        return this.id;
    }

    public String getTitle() {
        return this.title;
    }

    public String getLocation() {
        return this.location;
    }

    public int getSalaryMin() {
        return this.salaryMin;
    }

    public int getSalaryMax() {
        return this.salaryMax;
    }

    // Constructor đầy đủ tham số (Cập nhật thêm createdAt nếu cần)
    public Job(String title, String location, String description, int salaryMax, int salaryMin, int jobType, int status, int categoryId, int negotiable, LocalDate deadline) {
        this.title = title;
        this.location = location;
        this.description = description;
        this.salaryMax = salaryMax;
        this.salaryMin = salaryMin;
        this.jobType = jobType;
        this.status = status;
        this.categoryId = categoryId;
        this.negotiable = negotiable;
        this.deadline = deadline;
    }

    @Override
    public String toString() {
        return "Job{" + "id=" + id + ", title=" + title + ", location=" + location + ", status=" + status + ", deadline=" + deadline + "}";
    }
}