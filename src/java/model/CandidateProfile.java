package model;

public class CandidateProfile {
    private int id;
    private int userId;
    private String fullName;
    private String title;
    private String phone;
    private String location;
    private String aboutMe;
    private String avatarUrl;
    private String cvUrl;

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getFullName() {
        return fullName;
    }

    public String getTitle() {
        return title;
    }

    public String getPhone() {
        return phone;
    }

    public String getLocation() {
        return location;
    }

    public String getAboutMe() {
        return aboutMe;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public String getCvUrl() {
        return cvUrl;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setAboutMe(String aboutMe) {
        this.aboutMe = aboutMe;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public void setCvUrl(String cvUrl) {
        this.cvUrl = cvUrl;
    }

    
}