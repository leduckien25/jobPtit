package model;

public class Company {
    private int id;
    private String name;
    private String location;
    private String logoUrl;
    private String description;
    private int ownerUserId;
    private boolean isVerified;
    private int yearsExperience;
    private int projectsCount;
    private int countriesCount;
    private String techStack;

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getLocation() {
        return location;
    }

    public String getLogoUrl() {
        return logoUrl;
    }

    public String getDescription() {
        return description;
    }

    public int getOwnerUserId() {
        return ownerUserId;
    }

    public boolean isIsVerified() {
        return isVerified;
    }

    public int getYearsExperience() {
        return yearsExperience;
    }

    public int getProjectsCount() {
        return projectsCount;
    }

    public int getCountriesCount() {
        return countriesCount;
    }

    public String getTechStack() {
        return techStack;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setOwnerUserId(int ownerUserId) {
        this.ownerUserId = ownerUserId;
    }

    public void setIsVerified(boolean isVerified) {
        this.isVerified = isVerified;
    }

    public void setYearsExperience(int yearsExperience) {
        this.yearsExperience = yearsExperience;
    }

    public void setProjectsCount(int projectsCount) {
        this.projectsCount = projectsCount;
    }

    public void setCountriesCount(int countriesCount) {
        this.countriesCount = countriesCount;
    }

    public void setTechStack(String techStack) {
        this.techStack = techStack;
    }
    
    
}