/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author ducki
 */
public class Job {
    private int id;
    private String title;
    private String description;
    private String location;
    private Integer salaryMin;
    private Integer salaryMax;
    private boolean isNegotiable; 
    private int jobType; 
    private int status;  
    private int categoryId;
    private int companyId;
    private int createdByUserId;
    private int viewsCount;
    private LocalDateTime createdAt;
    private LocalDateTime expiredAt;
    private Company company;

    public boolean isIsNegotiable() {
        return isNegotiable;
    }

    public void setIsNegotiable(boolean isNegotiable) {
        this.isNegotiable = isNegotiable;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public Job() {}

    // Full Constructor (Useful for DAO results)
    public Job(int id, String title, String description, String location, Integer salaryMin, 
               Integer salaryMax, boolean isNegotiable, int jobType, int status, 
               int categoryId, int companyId, int createdByUserId, int viewsCount, 
               LocalDateTime createdAt, LocalDateTime expiredAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.location = location;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.isNegotiable = isNegotiable;
        this.jobType = jobType;
        this.status = status;
        this.categoryId = categoryId;
        this.companyId = companyId;
        this.createdByUserId = createdByUserId;
        this.viewsCount = viewsCount;
        this.createdAt = createdAt;
        this.expiredAt = expiredAt;
    }

    public String getJobTypeName() {
        return switch (this.jobType) {
            case 1 -> "Full-Time";
            case 2 -> "Part-Time";
            case 3 -> "Internship";
            default -> "Unknown";
        };
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public Integer getSalaryMin() { return salaryMin; }
    public void setSalaryMin(Integer salaryMin) { this.salaryMin = salaryMin; }

    public Integer getSalaryMax() { return salaryMax; }
    public void setSalaryMax(Integer salaryMax) { this.salaryMax = salaryMax; }

    public boolean isNegotiable() { return isNegotiable; }
    public void setNegotiable(boolean negotiable) { isNegotiable = negotiable; }

    public int getJobType() { return jobType; }
    public void setJobType(int jobType) { this.jobType = jobType; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public int getCompanyId() { return companyId; }
    public void setCompanyId(int companyId) { this.companyId = companyId; }

    public int getCreatedByUserId() { return createdByUserId; }
    public void setCreatedByUserId(int createdByUserId) { this.createdByUserId = createdByUserId; }

    public int getViewsCount() { return viewsCount; }
    public void setViewsCount(int viewsCount) { this.viewsCount = viewsCount; }

    public LocalDateTime getCreatedAt() { return createdAt; }
     public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getExpiredAt() { return expiredAt; }
    public void setExpiredAt(LocalDateTime expiredAt) { this.expiredAt = expiredAt; }
}
